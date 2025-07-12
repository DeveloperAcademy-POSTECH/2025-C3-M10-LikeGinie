//
//  CameraError.swift
//  PadoStudio
//
//  Created by eunsong on 7/11/25.
//
import Foundation

enum CameraError: LocalizedError, Identifiable {
    case noInput
    case cannotAddOutput
    case switchFailed
    case permissionDenied

    // MARK: - Identifiable
    var id: String { localizationKey }

    // MARK: - Localization
    var localizationKey: String {
        switch self {
        case .noInput:
            return "camera_error_no_input"
        case .cannotAddOutput:
            return "camera_error_cannot_add_output"
        case .switchFailed:
            return "camera_error_switch_failed"
        case .permissionDenied:
            return "camera_error_permission_denied"
        }
    }

    // MARK: - LocalizedError
    var errorDescription: String? {
        NSLocalizedString(localizationKey, comment: "")
    }
}
