import SwiftUI
import KingfisherSwiftUI

struct AlbumView: View {
  let album: Album
  
  var body: some View {
    VStack {
      AlbumCover(url: album.cover)
      AlbumTechDetailsView(album: album)
        .offset(y: -2)
      
      Text(album.displayTitle)
      Text(album.artist ?? "")
        .foregroundColor(.accentColor)
      Spacer()
    }
    .padding(ALBUM_PADDING)
    .frame(width: ALBUM_WIDTH, height: ALBUM_HEIGHT)
  }
}

struct Album_Previews: PreviewProvider {
  static var previews: some View {
    AlbumView(album: getTestAlbum())
  }
}
