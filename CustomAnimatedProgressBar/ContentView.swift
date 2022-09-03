import SwiftUI

struct ContentView: View {
    @State private var containerWidth: CGFloat = 0
    @State private var progressTitle: String = "0"

    var maxWidth: Double {
        return min(containerWidth / CGFloat(goal) * CGFloat(step), containerWidth)
    }

    private let goal = 3
    @State private var step = 0

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundColor(.clear)
                        .onAppear {
                            containerWidth = geo.size.width
                        }
                }

                RoundedRectangle(cornerRadius: 60)
                    .stroke(Color("BorderColor"), lineWidth: 1)

                ZStack(alignment: .trailing) {
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color("ProgressColor"))

                    Text("\(progressTitle)")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                        .background(
                            RoundedRectangle(cornerRadius: 60)
                                .fill(Color("CircleColor"))
                        )
                }
                .padding(2)
                .frame(minWidth: maxWidth)
                .fixedSize()
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(20)
            .onAppear {
                progressTitle = "\(step) / \(goal)"
            }

            Button("Start") {
                guard step < goal else { return }

                withAnimation(.linear(duration: 0.5)) {
                    step += 1
                }

                progressTitle = "\(step) / \(goal)"
            }
            .tint(Color("CircleColor"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
