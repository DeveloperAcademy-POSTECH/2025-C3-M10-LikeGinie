//
//  AppRoute.swift
//  PadoStudio
//
//  Created by eunsong on 5/28/25.
//


enum AppRoute: Hashable {
    case camera
    case gallery
    case startRecording
    case characterCreate(number: Int)
    case home
    case result(IdentifiableImage)
    case ImageCheck(IdentifiableImage)
}

