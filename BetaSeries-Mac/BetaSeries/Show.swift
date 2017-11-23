//
//  Show.swift
//  BetaSeries-Mac
//
//  Created by Victor Piolin on 23/11/2017.
//  Copyright © 2017 Victor Piolin. All rights reserved.
//

import Foundation

class Show {
    var Id:Int
    var Title:String
    var EpisodesUnseen:[Episode]
    
    init( id:Int, title:String, episodesunseen:[Episode] ) {
        self.Id = id
        self.Title = title
        self.EpisodesUnseen = episodesunseen
    }
 
    func getNbEpisode( ) -> Int {
        return self.EpisodesUnseen.count
    }
    
}
