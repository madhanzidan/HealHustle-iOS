//
//  QuotesAPI.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 28/07/22.
//

import SwiftUI

struct Quote: Codable, Hashable {
    var text: String
    var author: String?
}

struct QuotesAPI: View {
    @State private var quotes = [Quote]()
    
    var body: some View {
        NavigationView {
            List(quotes, id: \.self) { quote in
                VStack (alignment: .leading) {
                    Text("\"\(quote.text)\"")
                        .font(.system(size: 20).italic())
                        .foregroundColor(Color("DarkGrey"))
                    Text(quote.author ?? "")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Green"))
                }
            }
            .navigationBarHidden(true)
            .task {
                await fetchData()
            }
        }
    }
    
    func fetchData() async {
        //create url
        guard let url = URL(string: "https://type.fit/api/quotes") else {
            print("Hey yooo this URL doesn't work!")
            return
        }
        //fetch data from url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            //decode data
            print(data)
            if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                quotes = decodedResponse
                print(quotes)
            }
        } catch {
            print(error)
            print("Sorry, this data is not valid :(")
        }
        
    }
}

struct QuotesAPI_Previews: PreviewProvider {
    static var previews: some View {
        QuotesAPI()
    }
}
