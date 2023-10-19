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
    @State var pageNumber : Int = 0
    
    
    var body: some View {
        VStack {
            // Display page of the PDF
            PDFViewer(pageNumber: $pageNumber)
            HStack {
                Button(action: {
                    pageNumber-=1
                   
                }, label: {
                    Image(systemName: "arrowshape.left.fill").font(.largeTitle).padding(.leading)
                }).disabled(pageNumber == 0 ? true : false)
                Spacer()
                Button(action: {
                    pageNumber+=1
                   
                }, label: {
                    Image(systemName: "arrowshape.right.fill").font(.largeTitle).padding(.trailing)
            })
            }
            .navigationTitle(Text("Sayfa \(pageNumber)"))
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
   
  return ReadQuran()
}
