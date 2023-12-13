//
//  ContentView.swift
//  Calculator
//
//  Created by EIE3109 on 6/10/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var value="0"
    @State var isUserEnteringNumber=false

    
    func buttonWidth(item:CalcuButton)->CGFloat{
        let width=(UIScreen.main.bounds.width - (5*12))/4
        let padwidth=width/2
        
        
        if (UIDevice.current.userInterfaceIdiom == .pad){
            if (item == .zero) {
                return (padwidth*2)
            }
            return padwidth
        }
        else{
            if (item == .zero) {
                return (width*2)
            }
            return width
        }
    }
                    
    func buttonHeight()->CGFloat{
        let height=(UIScreen.main.bounds.width - (5*12))/4
        if (UIDevice.current.userInterfaceIdiom == .pad){
            return height/2
        }
        return height
    }
    
    func didTap(button: CalcuButton){
        if button.isDigit == true {
            digitPressed(button: button)
        } else {
            operationPressed(button: button)
        }
    }
    
    func digitPressed(button: CalcuButton){
        let number=button.rawValue
        if (self.isUserEnteringNumber == false){
            self.value="\(number)"
        }
        else{
            self.value="\(self.value)\(number)"
        }
        self.isUserEnteringNumber=true
    }
    
    func operationPressed(button: CalcuButton){
        
    }
    
    var body: some View {
        let buttons:[[CalcuButton]]=[
            [.clear,.negative,.percent,.divide],
            [.seven,.eight,.nine,.multiply],
            [.four,.five,.six,.substract],
            [.one,.two,.three,.add],
            [.zero,.decimal,.equal]
            ]
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size:100))
                        .foregroundColor(.white)
                }
                .padding()
                ForEach(buttons,id:\.self){row in
                    HStack(spacing:12){
                        ForEach(row,id:\.self){item in
                            Button(action:{
                                didTap(button: item)
                                print(item.rawValue)
                            },label:{
                                Text(item.rawValue)
                                    .font(.system(size:32))
                                    .frame(width:self.buttonWidth(item: item),height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonHeight()/2)
                            })
                        }
                    }
                    .padding(.bottom,3)
                }
            }
        }
    }
}


            
    


enum CalcuButton: String{
    case one="1"
    case two="2"
    case three="3"
    case four="4"
    case five="5"
    case six="6"
    case seven="7"
    case eight="8"
    case nine="9"
    case zero="0"
    case add="+"
    case substract="-"
    case multiply="x"
    case divide="/"
    case equal="="
    case clear="AC"
    case decimal="."
    case percent="%"
    case negative="+/-"
    
    var buttonColor: Color{
        switch self{
        case .add, .substract, .multiply, .divide, .equal:
            return .orange
        case .clear,.negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0,green: 55/255.0, blue:55/255.0, alpha: 1))
        }
        
    }
    
    var isDigit: Bool{
        switch self{
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .decimal:
            return true
        default:
            return false
        }
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
