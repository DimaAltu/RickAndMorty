//
//  String+Extension.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

import Foundation

extension String {
    func localizedValue() -> String {
        String(localized: LocalizedStringResource(stringLiteral: self))
    }
}
