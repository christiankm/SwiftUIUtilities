//
//  SearchBar.swift
//  SwiftUIUtilities
//
//  Created by Christian Mitteldorf on 06.05.2023.
//  Copyright © 2023 Mitteldorf. All rights reserved.
//

// Credit to Roddy Munro
// https://roddy.io/2020/09/07/add-search-bar-to-swiftui-picker/

import SwiftUI

public struct SearchBar: UIViewRepresentable {

    @Binding public var text: String

    public var placeholder: String

    public func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }

    public func makeCoordinator() -> SearchBar.Coordinator {
        Coordinator(text: $text)
    }

    public class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
}

#if DEBUG
struct SearchBarPreviews: PreviewProvider {

    struct FormView: View {

        let countries = ["Brazil", "Canada", "Egypt", "France", "Germany", "United Kingdom"]

        @State private var pickerSelection: String = ""
        @State private var searchTerm: String = ""

        var filteredCountries: [String] {
            countries.filter {
                searchTerm.isEmpty ? true : $0.lowercased().contains(searchTerm.lowercased())
            }
        }

        var body: some View {
            NavigationView {
                Form {
                    Picker(selection: $pickerSelection, label: Text("Countries")) {
                        SearchBar(text: $searchTerm, placeholder: "Search Countries")
                        ForEach(filteredCountries, id: \.self) { country in
                            Text(country).tag(country)
                        }
                    }
                }
            }
        }
    }

    static var previews: some View {
        FormView()
    }
}
#endif
