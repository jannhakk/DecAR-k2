//
//  Instructions.swift
//  DecAR
//
//  Created by iosdev on 8.12.2022.
//

import Foundation
import SwiftUI

let Sections = NSLocalizedString("Sections", comment: "Sections")
let SectionsBolded = NSLocalizedString("SectionsBolded", comment: "SectionsBolded")

let Section1Bolded = NSLocalizedString("Section1Bolded", comment: "Section1Bolded")
let Section1 = NSLocalizedString("Section1", comment: "Section1")

let Section2BoldedPart1 = NSLocalizedString("Section2BoldedPart1", comment: "Section2BoldedPart1")
let Section2Part1 = NSLocalizedString("Section2Part1", comment: "Section2Part1")
let Section2BoldedPart2 = NSLocalizedString("Section2BoldedPart2", comment: "Section2BoldedPart2")
let Section2Part2 = NSLocalizedString("Section2Part2", comment: "Section2Part2")

let Section3Bolded = NSLocalizedString("Section3Bolded", comment: "Section3Bolded")
let Section3 = NSLocalizedString("Section3", comment: "Section3")

let Section4Bolded = NSLocalizedString("Section4Bolded", comment: "Section4Bolded")
let Section4 = NSLocalizedString("Section4", comment: "Section4")

let Section5BoldedPart1 = NSLocalizedString("Section5BoldedPart1", comment: "Section5BoldedPart1")
let Section5Part1 = NSLocalizedString("Section5Part1", comment: "Section5Part1")
let Section5BoldedPart2 = NSLocalizedString("Section5BoldedPart2", comment: "Section5BoldedPart2")
let Section5Part2 = NSLocalizedString("Section5Part2", comment: "Section5Part2")
let Section5Italics = NSLocalizedString("Section5Italics", comment: "Section5Italics")

let Section6Bolded = NSLocalizedString("Section6Bolded", comment: "Section6Bolded")
let Section6 = NSLocalizedString("Section6", comment: "Section6")

struct InstructionsView: View {
  @State var locations: Array<ListingObject> = []
  
  var body: some View {
    ScrollView {
      VStack {
        Group {
          Spacer().frame(height: 25)
          Text(
            "\(Sections)**\(SectionsBolded)**"
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
          
          Text(
            "**\(Section1Bolded)**\(Section1)"
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
          
          Text(
            "**\(Section2BoldedPart1)**\(Section2Part1)**\(Section2BoldedPart2)**\(Section2Part2)"
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
        }
        
        Group {
          Text(
            "**\(Section3Bolded)**\(Section3)"
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
          
          Text(
            "**\(Section4Bolded)**\(Section4)"
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
          
          Text(
            "**\(Section5BoldedPart1)**\(Section5Part1)**\(Section5BoldedPart2)**\(Section5Part2)_\(Section5Italics)_."
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
          
          Text(
            "**\(Section6Bolded)**\(Section6)"
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
        }
      }
    }
  }
  
}
