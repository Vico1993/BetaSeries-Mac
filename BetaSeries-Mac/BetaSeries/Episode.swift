//
//  Episode.swift
//  BetaSeries-Mac
//
//  Created by Victor Piolin on 23/11/2017.
//  Copyright © 2017 Victor Piolin. All rights reserved.
//

import Foundation

class Episode {
    private var Id:Int
    private var Title:String
    private var Saison:Int
    private var Nb:Int
    private var Description:String
    private var Special:Int
    private var Link:String
    private var Date:String // -> Date Later
    
    init( id:Int, title:String, saison:Int, nb:Int, description:String, special:Int, link:String, date:String ) {
        self.Id = id
        self.Title = title
        self.Saison = saison
        self.Nb = nb
        self.Description = description
        self.Special = special
        self.Link = link
        self.Date = date
    }
    
    
}
