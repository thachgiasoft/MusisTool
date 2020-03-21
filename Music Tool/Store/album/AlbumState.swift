import Foundation

enum AlbumStatus: Int, Codable, Equatable {
  case new
  case parsingFiles
  case parsingFilesComplete
  case parsingFilesFailed
  case requestingMetadata
  case requestingMetadataComplete
  case requestingMetadataFailed
  case transcoding
  case transcodingComplete
  case transcodingFailed
}

//struct Track: Codable {
//  let number: Int
//  let artist: String
//  let title: String
//}

struct Album: Codable, Identifiable, Equatable {
  let id: UUID
  let url: URL
  let musicFiles: [URL]
  let imageFiles: [URL]
  let cueFiles: [URL]
  
  var title: String? = nil
  var artist: String? = nil
  var cover: URL? = nil
  
  var status: AlbumStatus

//  let tracks: [Track]

  var displayTitle: String {
    guard let title = self.title else {
      return self.url.lastPathComponent
    }
    
    return title
  }
}

extension Album {
  init(from albumDirectory: AlbumDirectory) {
    id = UUID(namespace: UUID_NAMESPACE, name: albumDirectory.url.absoluteString)!
    url = albumDirectory.url
    musicFiles = albumDirectory.musicFiles.sorted(by: { $0.lastPathComponent < $1.lastPathComponent})
    imageFiles = albumDirectory.imageFiles
    cueFiles = albumDirectory.cueFiles
    status = .new
    
    cover = getCoverURL(self)
  }
}

extension Album: CustomDebugStringConvertible {
  var debugDescription: String {
    return "\(displayTitle) | " +
      "music files: \(musicFiles.count) / " +
      "image files \(imageFiles.count) / " +
      "cue files \(cueFiles.count)"
  }
}

