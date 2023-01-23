import SwiftUI

struct PosterImage: View {
    let result: Result
    var width: CGFloat = 110
    var height: CGFloat = 160
    var alpha: CGFloat = 0.45
    var body: some View {
        VStack(alignment: .leading) {
            Image(url: "https://image.tmdb.org/t/p/w500/" + (result.image ?? ""), width: width, height: height, shadow: 5)
            VStack(alignment: .leading, spacing: 3) {
                Text(result.title)
                    .font(.headline)
                    .lineLimit(2)
                if let subTitle = result.subTitle {
                    Text(subTitle)
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
            .frame(minHeight: height * alpha, alignment: .top)
        }
        .frame(width: width)
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImage(result: .init(id: 1, title: "The Wilds", subTitle: "(2020)", image: "https://www.themoviedb.org/t/p/w1280/gHBtyMdHbWoM3tpM8VZymer8HfF.jpg", type: .tv))
    }
}
