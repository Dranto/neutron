import SwiftUI

struct ContentView: View {
    @State private var game = GameModel()
    @State private var lastTick: Date?

    private let timer = Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Canvas { context, _ in
                    context.addFilter(.shadow(color: .white.opacity(0.35), radius: 6))
                    for particle in game.particles {
                        draw(particle, in: &context)
                    }
                    drawPlayer(at: game.playerPosition, in: &context)
                }

                hud

                if game.phase != .playing {
                    menu
                }
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { game.movePlayer(to: $0.location.x) }
            )
            .onAppear { game.resize(to: proxy.size) }
            .onChange(of: proxy.size) { _, newSize in game.resize(to: newSize) }
        }
        .background(background)
        .onReceive(timer) { date in
            defer { lastTick = date }
            guard let lastTick else { return }
            game.step(dt: date.timeIntervalSince(lastTick))
        }
        .sensoryFeedback(.impact(weight: .light), trigger: game.photonsCollected)
        .sensoryFeedback(.error, trigger: game.gamesOver)
        .statusBarHidden()
    }

    // MARK: - Vues

    private var background: some View {
        LinearGradient(
            colors: [Color(red: 0.05, green: 0.04, blue: 0.20), .black],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private var hud: some View {
        VStack {
            HStack {
                Label("\(game.score)", systemImage: "atom")
                Spacer()
                Label("\(game.bestScore)", systemImage: "trophy.fill")
                    .foregroundStyle(.yellow)
            }
            .font(.title2.bold().monospacedDigit())
            .padding(.horizontal, 20)
            .padding(.top, 8)
            Spacer()
        }
        .allowsHitTesting(false)
    }

    private var menu: some View {
        VStack(spacing: 20) {
            if game.phase == .ready {
                Text("NEUTRON")
                    .font(.system(size: 48, weight: .black, design: .rounded))
                Text("Glisse ton doigt pour déplacer le neutron.\nÉvite les protons rouges, attrape les photons jaunes !")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            } else {
                Text("Collision !")
                    .font(.system(size: 40, weight: .black, design: .rounded))
                Text("Score : \(game.score)")
                    .font(.title.monospacedDigit())
                if game.isNewBest {
                    Text("Nouveau record !")
                        .font(.headline)
                        .foregroundStyle(.yellow)
                }
            }

            Button {
                lastTick = nil
                game.start()
            } label: {
                Text(game.phase == .ready ? "Jouer" : "Rejouer")
                    .font(.title2.bold())
                    .frame(minWidth: 160)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.borderedProminent)
            .tint(.cyan)
        }
        .padding(32)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 28))
        .padding(24)
    }

    // MARK: - Dessin

    private func draw(_ particle: Particle, in context: inout GraphicsContext) {
        let rect = CGRect(
            x: particle.position.x - particle.radius,
            y: particle.position.y - particle.radius,
            width: particle.radius * 2,
            height: particle.radius * 2
        )
        let colors: [Color] = switch particle.kind {
        case .proton: [.orange, .red]
        case .photon: [.white, .yellow]
        }
        context.fill(
            Path(ellipseIn: rect),
            with: .radialGradient(
                Gradient(colors: colors),
                center: particle.position,
                startRadius: 0,
                endRadius: particle.radius
            )
        )
    }

    private func drawPlayer(at position: CGPoint, in context: inout GraphicsContext) {
        let radius = GameModel.playerRadius
        let rect = CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2)
        context.fill(
            Path(ellipseIn: rect),
            with: .radialGradient(
                Gradient(colors: [.white, .cyan, .blue]),
                center: CGPoint(x: position.x - radius / 3, y: position.y - radius / 3),
                startRadius: 0,
                endRadius: radius * 1.4
            )
        )
        context.draw(
            Text("n").font(.system(size: 20, weight: .bold, design: .rounded)).foregroundStyle(.black.opacity(0.7)),
            at: position
        )
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
