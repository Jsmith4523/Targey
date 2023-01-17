//
//  View+EXT.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import Foundation
import SwiftUI

extension View {
    
    func ratingView(rating: Double, reviewCount: Int) -> some View {
        let rating = Int(rating)
        
        return HStack(spacing: 5) {
            ForEach(0..<5, id: \.self) { int in
                Image(systemName: int < rating ? "star.fill" : "star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor( int < rating ? .yellow : .secondary)
            }
        }
    }

    func storeGlyph() -> some View {
        Image("store")
            .resizable()
            .scaledToFill()
            .frame(width: 70, height: 70)
            .clipShape(Circle())
    }
    
    func largeButtonStyle(backgroundColor: Color = .targetRed)  -> some View {
        return self
            .padding()
            .foregroundColor(.white)
            .background(backgroundColor)
            .clipShape(Circle())
    }
    
    ///Custom bindale UISheetPresentationController with detents and other parameters for SwiftUI views.
    func customSheetView<Content: View>(isPresented: Binding<Bool>, detents: [UISheetPresentationController.Detent] = [.medium(), .large()], showsIndicator: Bool = false, cornerRadius: CGFloat = 15, child: @escaping () -> Content) -> some View {
        return self
            .background(content: {
                CustomSheetView(isPresented: isPresented, detents: detents, showsIndicator: showsIndicator, cornerRadius: cornerRadius, child: child)
            })
    }
}


struct CustomSheetView<Content: View>: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    
    let detents: [UISheetPresentationController.Detent]
    let showsIndicator: Bool
    let cornerRadius: CGFloat
    let child: () -> Content
        
    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if isPresented {
            let hosting = DetentiveController(
                detents: self.detents,
                showIndicator: self.showsIndicator,
                cornerRadius: self.cornerRadius,
                content: self.child
            )
            
            uiViewController.present(hosting, animated: true) {
                DispatchQueue.main.async {
                    self.isPresented.toggle()
                }
            }
        }
    }
}

class DetentiveController<Content: View>: UIHostingController<Content> {
    
    let detents: [UISheetPresentationController.Detent]
    let showIndicator: Bool
    let cornerRadius: CGFloat
    let content: () -> Content
    
    init(detents: [UISheetPresentationController.Detent], showIndicator: Bool, cornerRadius: CGFloat, content: @escaping () -> Content) {
        self.detents        = detents
        self.showIndicator  = showIndicator
        self.cornerRadius   = cornerRadius
        self.content        = content
        
        super.init(rootView: content())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sheetController = sheetPresentationController {
            sheetController.detents               = self.detents
            sheetController.prefersGrabberVisible = self.showIndicator
            sheetController.preferredCornerRadius = self.cornerRadius
        }
    }
}

struct ActivityController: UIViewControllerRepresentable {
    
    let activities: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let vc = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
    
    typealias UIViewControllerType = UIActivityViewController
    
}
