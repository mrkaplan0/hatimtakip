//
//  ReadQuran.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 15.10.23.
//

import SwiftUI
import PDFKit

struct ReadQuran: View {
    let pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "kuran", withExtension: "pdf")!)
    @EnvironmentObject var readingViewModel : ReadingViewModel
    @Environment(\.dismiss) var dismiss
    @State var pageNumber : Int = 0
    @State private var isPartFinished = false
    @Binding var part : HatimPartModel
    let isFromMyIndividualPage : Bool
   // let readQuranPageNavTitle : LocalizedStringKey = "Sayfa %@"
    let readQuranText : LocalizedStringKey = "Kuran Oku"
    
    var body: some View {
        VStack {
            // Display page of the PDF
            PDFViewer(pageNumber: $pageNumber)
                .navigationTitle(Text(readQuranText))
            if isFromMyIndividualPage == true {
                HStack {
                    //undo Button
                    Button(action: {
                        if part.remainingPages.count != 0 {
                            let firstItem : Int = part.remainingPages.first!
                            let newItem : Int = firstItem-1
                            part.remainingPages.insert(newItem, at: 0)
                            pageNumber = part.remainingPages.first ?? 0
                        } else {
                            part.remainingPages.append(part.pages.last!)
                        }
                        
                        readingViewModel.updatePart(part: part)

                    }, label: {
                        Image(systemName: "arrowshape.left.fill").font(.largeTitle).padding(.leading)
                    }).disabled(part.remainingPages.first == part.pages.first || pageNumber == 0 ? true : false)
                    Spacer()
                        Text("\(pageNumber)")
                    Spacer()
                    //decreaseButton
                    Button(action: {
                        
                        part.remainingPages.removeFirst()
                        if part.remainingPages.count == 0 {
                            isPartFinished = true
                        } else {
                            pageNumber = part.remainingPages.first ?? 0
                        }
                        
                        readingViewModel.updatePart(part: part)
                       
                    }, label: {
                        Image(systemName: "arrowshape.right.fill").font(.largeTitle).padding(.trailing)
                })
                }
            }
            if isFromMyIndividualPage == false {
                PageChangingButtons(pageNumber: $pageNumber)
            }
                
        }.onAppear(perform: {
            pageNumber = part.remainingPages.first ?? 0
        })
        
        //sheets
        .sheet(isPresented: $isPartFinished) {
            isPartFinished = false
            dismiss()
        } content: {
           CongratulationsSheet()
        }
    }
}

struct PageChangingButtons: View {
    @Binding var pageNumber : Int
    var body: some View {
        HStack {
            Button {
                pageNumber-=1
            } label: {
                Image(systemName: "arrowshape.left.fill").font(.largeTitle).padding(.leading)
            }.disabled(pageNumber == 0 ? true : false)
            Spacer()
            Text("Sayfa \(pageNumber)")
            Spacer()
            Button {
                pageNumber+=1
            } label: {
                Image(systemName: "arrowshape.right.fill").font(.largeTitle).padding(.trailing)
            }

        }
    }
}


struct PDFViewer: UIViewRepresentable {
    @Binding var pageNumber: Int
    
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.displayMode = .singlePage
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        if let pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "kuran", withExtension: "pdf")!) {
            uiView.document = pdfDocument
            uiView.autoScales = true
            let aa = uiView.document!.page(at: pageNumber + 1)
            uiView.go(to: aa!)
        }
    }

}

#Preview {
    @State var part = HatimPartModel(hatimID: "", hatimName: "", pages: [461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480], remainingPages: [461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480], isPrivate: false)
    return ReadQuran(part: $part, isFromMyIndividualPage: false).environmentObject(ReadingViewModel())
}
