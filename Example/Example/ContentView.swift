import SwiftUI

struct ContentView: View {
  @State private var path = NavigationPath()

  var body: some View {
    NavigationStack(path: $path) {
      List {
        Section("Foundation") {
          ForEach(FoundationPages.allCases) { page in
            NavigationLink(page.title, value: page)
          }
        }
      }
      .navigationFoundationPages()
    }
  }
}
