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
        }
    }

    // MARK: - LocalizedError
    var errorDescription: String? {
        NSLocalizedString(localizationKey, comment: "")
    }
}
