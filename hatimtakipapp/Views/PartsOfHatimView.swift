//
//  PartsOfHatimView.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 28.08.23.
//

import SwiftUI

struct PartsOfHatimView: View {
    @State var allParts = [cuz1, cuz2, cuz3, cuz4, cuz5, cuz6, cuz7, cuz8, cuz9, cuz10, cuz11, cuz12, cuz13, cuz14, cuz15, cuz16, cuz17,cuz18, cuz19, cuz20, cuz21, cuz22, cuz23, cuz24, cuz25, cuz26, cuz27,cuz28, cuz29, cuz30 ]
          let parttext = "Cüz"
          let splitButtontext = "Böl"
    @State private var showingSheet = false
    @State var selectedCuz = [Int]()
    
    
    var body: some View {
      
        List{
            ForEach(0..<allParts.count, id: \.self) { i in
                let element = allParts[i]
                
                RoundedRectangle(cornerRadius: 8).stroke()
                    .frame(height: 50).padding(.horizontal)
                    .overlay {
                        HStack (spacing: 30){
                            Text("\(i + 1)")
                          
                            if element.count == 20 {
                                Text("\(parttext) \(i + 1)")
                            }else{
                                // else is complicated now :)
                                Text("\(element.first ?? 0) - \(element.last ?? 0)")
                            }
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(splitButtontext) {
                            selectedCuz = allParts[i]
                            showingSheet.toggle()
                        }
                       
                        }
                    }
            }
        .sheet(isPresented: $showingSheet) {
            SheetView(allParts: $allParts, selectedCuz: $selectedCuz)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        
       
        
        
   
    }
    
  
}

struct SheetView: View {
    @Binding var allParts : [[Int]]
    @Binding var selectedCuz : [Int]
    @Environment(\.dismiss) var dismiss
    @State private var splitPage: Double = 0
    let splitPagestext = "sayfadan böl"
    let buttonConfirmText = "Böl"
    let buttonDismissText = "Iptal"
    
   
    
    var body: some View {
        VStack {
            Slider(value: $splitPage, in: 0...20).padding(.horizontal)
            Text("\(Int(splitPage)).")
            Text("\(splitPagestext)")
            
            Spacer()
            HStack {
                Button {
                    var newList = [Int]()
                    let indexOfSelectedCuz = allParts.firstIndex(of: selectedCuz)
                    selectedCuz.sort{
                        $0<$1
                    }
                    for i in 0..<Int(splitPage) {
                        newList.append(selectedCuz[i])
                        
                    }
                    for i in 0..<Int(splitPage) {
                        selectedCuz.removeFirst()
                    }
                    allParts.insert(newList, at: indexOfSelectedCuz!)
                    allParts[indexOfSelectedCuz! + 1] = selectedCuz
                    print(newList)
                    print(selectedCuz)
                    
                    dismiss()
                    
                } label: {
                    CustomButtonStyle(buttonText: buttonConfirmText, buttonColor: .orange)
                }
                Button {
                    dismiss()
                } label: {
                    CustomButtonStyle(buttonText: buttonDismissText, buttonColor: .orange).foregroundColor(.orange)
                }
            }
        }
        
    }
}


var cuz1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
var cuz2 = [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]
var cuz3 = [41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60]
var cuz4 = [61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]
var cuz5 = [ 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100]
var cuz6 = [101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120]
var cuz7 = [ 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140]
var cuz8 = [141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160,]
var cuz9 = [ 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180]
var cuz10 = [ 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200]
var cuz11 = [ 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220]
var cuz12 = [221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, ]
var cuz13 = [ 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, ]
var cuz14 = [  261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, ]
var cuz15 = [ 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300]
var cuz16 = [ 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, ]
var cuz17 = [ 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, ]
var cuz18 = [ 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, ]
var cuz19 = [ 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380]
var cuz20 = [ 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, ]
var cuz21 = [ 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, ]
var cuz22 = [421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, ]
var cuz23 = [ 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, ]
var cuz24 = [461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480]
var cuz25 = [ 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, ]
var cuz26 = [501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, ]
var cuz27 = [521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, ]
var cuz28 = [ 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, ]
var cuz29 = [ 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, ]
var cuz30 = [581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602]
enum cuz  : String {
    case cuz1 = "1 - 20"
    case two = "21 - 40"
    case three = "41 - 60"
    case four = "61 - 80"
    case five = "81 - 100"
    case six  = "101 - 120"
    case seven = "121 - 140"
    case eight = "141 - 160"
    case nine = "161 - 180"
    case ten = "181 - 200"
    case eleven = "201 - 220"
    case twelve = "221 - 240"
    case thirteen = "241 - 260"
    case fourteen = "261 - 280"
    case fifteen = "281 - 300"
    case sixteen = "301 - 320"
    case seventeen = "321 - 340"
    case eighteen = "341 - 360"
    case nineteen = "361 - 380"
    case twenty = "381 - 400"
    case twentyone = "401 - 420"
    case twentytwo = "421 - 440"
    case twentythree = "441 - 460"
    case twentyfour = "461 - 480"
    case twentyfive = "481 - 500"
    case twentysix = "501 - 520"
    case twentyseven = "521 - 540"
    case twentyeight = "541 - 560"
    case twentynine = "561 - 580"
    case thirty = "581 - 602"
   
    
}

struct PartsOfHatimView_Previews: PreviewProvider {
    static var previews: some View {
        PartsOfHatimView()
    }
}
