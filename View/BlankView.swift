import SwiftUI

struct BlankView: View {
    var body: some View {
        Color.black
            .opacity(0.5)
            .ignoresSafeArea()
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView()
    }
}
