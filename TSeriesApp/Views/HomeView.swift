

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.rows) { row in
                    PosterRow(title: row.title, results: row.list.results, endpoint: row.endpoint, params: row.parameters)
                        .padding(.vertical, 5)
                }
            }
            .toSearchView()
            .navigationTitle("TSeriesApp")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
