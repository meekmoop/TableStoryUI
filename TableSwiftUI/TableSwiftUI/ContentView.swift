//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Goodlow, Avery on 4/1/24.
//

import SwiftUI
import MapKit


let data = [
Item(name: "Leopard Lounge", neighborhood: "North Loop", desc: "Leopard Lounge has been known to have the best curated selection of vintage in Texas for over 20 years. Leopard Lounge continues to be the go-to spot in Texas for true vintage, Americana and 1920’s – 2000’s clothing.", lat: 30.299040, long: -97.741135, imageName: "2"),
Item(name: "Buffalo Exchange", neighborhood: "North Campus", desc: "Hip chain that buys, sells, trades trendy vintage & used clothing plus accessories for men & women. ThrIMG_4067ift for all genders.", lat: 30.293440, long: -97.741445, imageName: "3"),
Item(name: "Stitches Vintage", neighborhood: "North Loop", desc: "Americana boutique vintage store located in Austin, TX. On the historic street of North Loop.", lat: 30.315506, long: -97.724354, imageName: "4"),
Item(name: "Ermine Vintage", neighborhood: "North Loop", desc: "Independent shop selling retro T-Shirts, jeans, shoes & funky accessories for men & women. Offers a curated selection of vintage-inspired jewelry and unique handcrafted items.", lat: 30.319142, long: -97.720668, imageName: "5"),
Item(name: "Room Service Vintage", neighborhood: "North Loop", desc: "Quirky shop with a rotating supply of vintage furniture, decor, jewelry & more from the 50's-70's. A treasure trove for nostalgic shoppers.", lat: 30.319058, long: -97.719604, imageName: "6"),
Item(name: "Big Bertha's Paradise", neighborhood: "North Loop", desc: "Boutique for womenswear from designer labels, some vintage, in petite, well-stocked digs. Showcasing emerging designers and local artisans.", lat: 30.318601, long: -97.719438, imageName: "7"),
Item(name: "Blue Velvet", neighborhood: "North Loop", desc: "Funky, long-standing shop packed with men's & women's vintage clothing, costumes & accessories. Drawing fashion enthusiasts seeking one-of-a-kind pieces and rare finds.", lat: 30.319021, long: -97.718378, imageName: "8"),
Item(name: "Revival Vintage", neighborhood: "North Loop", desc: "Mid-century modern to on-trend vintage furniture and decor located in Austin. Vintage unisex clothing, plants, and gift items. Creating a unique shopping experience in the heart of Austin.", lat: 30.321052, long: -97.721896, imageName: "9"),
Item(name: "Uptown Modern", neighborhood: "Crestview", desc: "Refurbished European and American midcentury-modern furniture dealer that also sells jewelry.", lat: 30.326451, long: -97.738601, imageName: "10"),
Item(name: "Thrift House", neighborhood: "Crestview", desc: "A volunteer-run resale department store that provides high-quality goods to our community. The store is open year-round and serves as a major source of income for Assistance League of Austin’s philanthropic programs.", lat: 30.327473, long: -97.739653, imageName: "11"),
Item(name: "Prisma Vintage", neighborhood: "East Cesar Chavez", desc: "Vintage for everyone: all sizes & all eras! Offers vintage clothing and accessories spanning all sizes and eras, ensuring there's something special for every shopper to discover.", lat: 30.264670, long: -97.730190, imageName: "12"),
Item(name: "Pavement (S. Lamar)", neighborhood: "Zilker", desc: "Pavement is a larger-than-life buy/sell/trade shop offering a wide variety of new and used clothing, shoes, and accessories. A favorite destination for both fashion-forward trendsetters and thrifty shoppers alike.", lat: 30.252320, long: -97.764130, imageName: "1"),
Item(name: "City-Wide Garage Sale", neighborhood: "Bouldin Creek", desc: "This event features tons of vintage finds, antiques, estate jewelry and more! Keeping Austin vintage since 1977, the name “City-Wide” has become an iconic event held in Austin and surrounding towns multiple times a year.", lat: 30.258710, long: -97.751870, imageName: "14"),
Item(name: "Charm School Vintage", neighborhood: "East Cesar Chavez", desc: "East Austin's mecca for must-have vintage clothing, handpicked with love and an eye for fun, functionality, and timeless style. Curated selection of clothing that celebrates individuality, creativity, and enduring fashion flair.", lat: 30.267078, long: -97.729471, imageName: "15"),
Item(name: "Pavement (Guadalupe)", neighborhood: "North Campus", desc: "Pavement is a larger-than-life buy/sell/trade shop offering a wide variety of new and used clothing, shoes, and accessories. A favorite destination for both fashion-forward trendsetters and thrifty shoppers alike.", lat: 30.291918, long: -97.741159, imageName: "13")
]

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let neighborhood: String
    let desc: String
    let lat: Double
    let long: Double
    let imageName: String
}


struct ContentView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.726220), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    
    var body: some View {
        NavigationView {
        VStack {
            List(data, id: \.name) { item in
                NavigationLink(destination: DetailView(item: item)) {
                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.neighborhood)
                                .font(.subheadline)
                        } // end internal VStack
                    } // end HStack
                }// end NavigationLink
            } // end List
            Map(coordinateRegion: $region, annotationItems: data) { item in
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                                    .overlay(
                                        Text(item.name)
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                            .fixedSize(horizontal: true, vertical: false)
                                            .offset(y: 25)
                                    )
                            }
                        } // end map
                        .frame(height: 300)
                        .padding(.bottom, -30)
        } // end VStack
        .listStyle(PlainListStyle())
                .navigationTitle("Austin Vintage Stores")
            } // end NavigationView
    } // end body
} // end ContentView

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var region: MKCoordinateRegion
    
    let item: Item
    
    init(item: Item) {
        self.item = item
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
    }
    
    var body: some View {
        VStack {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 200)
            
            Text(item.name)
                .font(Font.title.weight(.bold))
            
            Text("Neighborhood: \(item.neighborhood)")
                .font(.subheadline)
            
            Text("\(item.desc)")
                .font(.subheadline)
                .padding(10)
            
            Map(coordinateRegion: $region, annotationItems: [item]) { item in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                        .overlay(
                            Text(item.name)
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: true, vertical: false)
                                .offset(y: 25)
                        )
                }
            }
            .frame(height: 300)
            .padding(.bottom, -30)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true) // Hide default back button
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.primary)
        }, trailing: EmptyView())
    }
}


    #Preview {
        ContentView()
    }
