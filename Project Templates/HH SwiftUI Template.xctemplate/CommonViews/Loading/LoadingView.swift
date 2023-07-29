//___FILEHEADER___

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        GeometryReader { geo in
            ProgressView()
                .frame(width: geo.size.width,
                       height: geo.size.height,
                       alignment: .center)
                .background(.gray.opacity(0.6))
        }
    }
    
}

struct LoadingView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoadingView()
    }
    
}
