import SwiftUI

struct ContentView2: View {
    @State private var containerWidth: CGFloat = 0
    @State private var progressTitle: String = ""
    @State private var progress: Int = 0

    var maxWidth: Double {
        return min(Double(progress), containerWidth)
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
                        .monospaced()
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
                progressTitle = "\(progress)%"
            }

            Button("Start") {
                progress = 0

                Task {
                    for i in 1 ... 100 {
                        try await Task.sleep(until: .now.advanced(by: .milliseconds(30)), clock: .continuous)
                        progressTitle = "\(i)%"
                        withAnimation {
                            progress = Int(Double(containerWidth) / 100 * Double(i))
                        }
                    }
                }
            }
            .tint(Color("CircleColor"))
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
