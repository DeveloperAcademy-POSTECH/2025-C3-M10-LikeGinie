//
//  CharacterViewModel.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//
import SwiftUI

final class CharacterViewModel: ObservableObject {
    @Published var selections: [Int: [CharacterPartType: CharacterAsset]] = [:]
    @Published var selectedPart: CharacterPartType = .hair

    let assets: [CharacterAsset] = CharacterAssetMock.mockCharacterAssets

    func select(asset: CharacterAsset, index: Int) {
        if selections[index] == nil {
            selections[index] = [:]
        }
        selections[index]?[asset.part] = asset
    }

    func getPreview(for part: CharacterPartType, index: Int) -> String? {
        selections[index]?[part]?.imageName
    }
    
    func getOriginImageName(for part: CharacterPartType, index: Int) -> String? {
        selections[index]?[part]?.originName
    }

    func getOriginImageNames(for index: Int) -> [String] {
        return selections[index]?.values.map { $0.originName } ?? []
    }

    func selectedAsset(for part: CharacterPartType, index: Int) -> CharacterAsset? {
        selections[index]?[part]
    }
    
    // 카메라에서 사용할 완성된 캐릭터들을 반환하는 함수 (각 캐릭터는 하나의 단위로)
    func getCompletedCharacters() -> [[String]] {
        var completedCharacters: [[String]] = []
        
        // 모든 인덱스에 대해 완성된 캐릭터 수집
        for index in selections.keys.sorted() {
            let characterParts = getOriginImageNames(for: index)
            if !characterParts.isEmpty {
                completedCharacters.append(characterParts)
            }
        }
        
        return completedCharacters
    }
    
    // 카메라에서 사용할 캐릭터 이미지 이름들을 반환하는 함수 (하위 호환성을 위해 유지)
    func getAllCharacterImageNames() -> [String] {
        let completedCharacters = getCompletedCharacters()
        return completedCharacters.flatMap { $0 }
    }
    
    // 특정 인덱스의 완성된 캐릭터 이미지들을 반환
    func getCharacterImagesForIndex(_ index: Int) -> [String] {
        return getOriginImageNames(for: index)
    }
    
    // 모든 완성된 캐릭터들의 이미지 배열을 반환 (인덱스별로 그룹화)
    func getAllCompletedCharacters() -> [[String]] {
        var completedCharacters: [[String]] = []
        
        for index in selections.keys.sorted() {
            let characterImages = getOriginImageNames(for: index)
            if !characterImages.isEmpty {
                completedCharacters.append(characterImages)
            }
        }
        
        return completedCharacters
    }
    
    // 캐릭터가 생성되었는지 확인하는 함수
    func hasCharacters() -> Bool {
        return !selections.isEmpty && selections.values.contains { !$0.isEmpty }
    }
    
    // 특정 인덱스에 캐릭터가 있는지 확인
    func hasCharacter(at index: Int) -> Bool {
        return selections[index]?.isEmpty == false
    }
    
    // 전체 캐릭터 초기화
    func resetAllCharacters() {
        selections.removeAll()
    }
    
    // 특정 인덱스 캐릭터 초기화
    func resetCharacter(at index: Int) {
        selections[index] = [:]
    }
}
