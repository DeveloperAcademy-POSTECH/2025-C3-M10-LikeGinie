
enum FrameType: String, CaseIterable, Hashable {
    case sea, sunset, comic, white, black

    var imgName: String {
        switch self {
        case .sea: return "frame_sea"
        case .sunset: return "frame_sunset"
        case .comic: return "frame_comic"
        case .white: return "frame_white"
        case .black: return "frame_black"
        }
    }

    var btnImgName: String {
        switch self {
        case .sea: return "frame_btn_sea"
        case .sunset: return "frame_btn_sunset"
        case .comic: return "frame_btn_comic"
        case .white: return "frame_btn_white"
        case .black: return "frame_btn_black"
        }
    }
}
