import CoreGraphics
import Foundation
import Observation

/// Une particule qui tombe du haut de l'écran.
struct Particle: Identifiable {
    enum Kind {
        /// Mortel : il faut l'éviter.
        case proton
        /// Bonus : à attraper pour gagner des points.
        case photon
    }

    let id = UUID()
    let kind: Kind
    var position: CGPoint
    let radius: CGFloat
    /// Vitesse de chute en points par seconde (avant multiplicateur de difficulté).
    let speed: CGFloat
}

/// Toute la logique du jeu, indépendante de l'affichage.
@Observable
final class GameModel {
    enum Phase {
        case ready, playing, gameOver
    }

    static let playerRadius: CGFloat = 20
    static let photonBonus = 25
    private static let bestScoreKey = "bestScore"

    private(set) var phase: Phase = .ready
    private(set) var particles: [Particle] = []
    private(set) var playerX: CGFloat = 0
    private(set) var score = 0
    private(set) var bestScore: Int
    private(set) var isNewBest = false
    /// Compteurs servant de déclencheurs pour les retours haptiques.
    private(set) var photonsCollected = 0
    private(set) var gamesOver = 0

    private var size: CGSize = .zero
    private var elapsed: TimeInterval = 0
    private var bonus = 0
    private var spawnCountdown: TimeInterval = 0
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        bestScore = defaults.integer(forKey: Self.bestScoreKey)
    }

    var playerPosition: CGPoint {
        CGPoint(x: playerX, y: max(Self.playerRadius, size.height - 90))
    }

    // MARK: - Commandes

    func resize(to newSize: CGSize) {
        let isFirstLayout = size == .zero
        size = newSize
        playerX = isFirstLayout || phase != .playing ? newSize.width / 2 : clampedX(playerX)
    }

    func movePlayer(to x: CGFloat) {
        guard phase == .playing else { return }
        playerX = clampedX(x)
    }

    func start() {
        particles = []
        score = 0
        bonus = 0
        elapsed = 0
        spawnCountdown = 0.5
        isNewBest = false
        playerX = size.width / 2
        phase = .playing
    }

    /// Fait avancer la simulation de `dt` secondes.
    func step(dt: TimeInterval) {
        guard phase == .playing, size.width > 80, dt > 0 else { return }
        let dt = min(dt, 1.0 / 20) // évite les sauts après une pause
        elapsed += dt
        let difficulty = 1 + elapsed / 25

        spawnCountdown -= dt
        if spawnCountdown <= 0 {
            spawnParticle()
            spawnCountdown = max(0.18, 0.75 / difficulty)
        }

        for index in particles.indices {
            particles[index].position.y += particles[index].speed * CGFloat(difficulty * dt)
        }
        particles.removeAll { $0.position.y - $0.radius > size.height }

        let player = playerPosition
        var hitProton = false
        var collectedIDs: Set<UUID> = []
        for particle in particles {
            let distance = hypot(particle.position.x - player.x, particle.position.y - player.y)
            // Hitbox légèrement indulgente pour que les collisions paraissent justes.
            guard distance < (particle.radius + Self.playerRadius) * 0.85 else { continue }
            switch particle.kind {
            case .proton:
                hitProton = true
            case .photon:
                collectedIDs.insert(particle.id)
            }
        }
        if !collectedIDs.isEmpty {
            particles.removeAll { collectedIDs.contains($0.id) }
            bonus += Self.photonBonus * collectedIDs.count
            photonsCollected += collectedIDs.count
        }

        score = Int(elapsed * 10) + bonus
        if hitProton {
            endGame()
        }
    }

    // MARK: - Interne

    private func spawnParticle() {
        let isPhoton = Double.random(in: 0..<1) < 0.18
        let radius: CGFloat = isPhoton ? 12 : .random(in: 14...28)
        let x = CGFloat.random(in: radius...(size.width - radius))
        particles.append(Particle(
            kind: isPhoton ? .photon : .proton,
            position: CGPoint(x: x, y: -radius),
            radius: radius,
            speed: .random(in: 180...300)
        ))
    }

    private func endGame() {
        phase = .gameOver
        gamesOver += 1
        if score > bestScore {
            bestScore = score
            isNewBest = true
            defaults.set(score, forKey: Self.bestScoreKey)
        }
    }

    private func clampedX(_ x: CGFloat) -> CGFloat {
        min(max(x, Self.playerRadius), max(Self.playerRadius, size.width - Self.playerRadius))
    }
}
