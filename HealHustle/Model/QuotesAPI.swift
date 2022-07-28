//
//  QuotesAPI.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 28/07/22.
//

import SwiftUI

struct Quote: Codable {
    var quote_id: Int
    var quote: String
    var author: String
    //var series: String
}

struct QuotesAPI: View {
    @State private var quotes = [Quote]()
    
    var body: some View {
        NavigationView {
            List(quotes, id: \.quote_id) { quote in
                VStack (alignment: .leading) {
                    Text("\"\(quote.quote)\"")
                        .font(.system(size: 20).italic())
                        //.fontWeight(.medium)
                        .foregroundColor(Color("DarkGrey"))
                    Text(quote.author)
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
        guard let url = URL(string: "https://www.breakingbadapi.com/api/quotes") else {
            print("Hey yooo this URL doesn't work!")
            return
        }
        //fetch data from that url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //decode that data
            if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                quotes = decodedResponse
            }
        } catch {
            print("Sorry, this data is not valid :(")
        }
        
    }
}

struct QuotesAPI_Previews: PreviewProvider {
    static var previews: some View {
        QuotesAPI()
    }
}
