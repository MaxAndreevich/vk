//
//  MessangesPresenter.swift
//  VK
//
//  Created by Максим Разумов on 23.09.2020.
//  Copyright © 2020 Максим Разумов. All rights reserved.
//

import Foundation

class MessangesPresenter {
    
    weak var viewController: MessangesViewController?
    var messange: [Messange] = [Messange(name: "Sender name",
                                avatarURL: URL(string: "https://m.thepeoplesdialogue.org.za/Assets/images/about-herman.png"),
                                messange: "Last messange and date")]
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return messange.count
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> Messange {
        var messangeModel = Messange(name: messange[indexPath.row].name,
                               avatarURL: messange[indexPath.row].avatarURL,
                               messange: messange[indexPath.row].messange)
        
        return messangeModel
    }
    
}
