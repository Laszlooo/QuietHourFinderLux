import SwiftUI

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        HomeView()
            .scrollIndicators(.hidden)
            .preferredColorScheme(themeManager.theme.colorScheme)
    }
}
   
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(ThemeManager())
                .preferredColorScheme(.light)
            
            ContentView()
                .environmentObject(ThemeManager())
                .preferredColorScheme(.dark)
        }
    }
}
