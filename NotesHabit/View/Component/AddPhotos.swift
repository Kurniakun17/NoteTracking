import SwiftUI

struct AddPhotos: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedImages: [UIImage] = []
    @State private var isPickerPresented: Bool = false
    
    var body: some View {
        NavigationView{
            VStack(spacing: 28){
                
                FotoElement(openGallery: {
                    isPickerPresented.toggle()
                })
                .sheet(isPresented: $isPickerPresented) {
                    PhotoPicker(selectedImages: $selectedImages)
                        .edgesIgnoringSafeArea(.bottom)
                }
                
                
                if !selectedImages.isEmpty{
                    VStack{
                        ZStack{
                            HStack{
                                Spacer()
                                    .frame(width: 315)
                                Button(action: {
                                    selectedImages.removeAll()
                                    
                                    
                                }, label: {
                                    Image(systemName: "x.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15, height: 15)
                                        .foregroundColor(.gray)
                                    
                                })
                            }
                            .zIndex(1)
                            .offset(y: -43)
                            .padding(.top, -7)
                            
                            Rectangle()
                                .frame(width: 344, height: 120)
                                .cornerRadius(16)
                                .foregroundColor(.white)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(selectedImages, id: \.self) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 80)
                                        
                                    }
                                }
                                .padding(.horizontal, 10)
                                .padding(.top, 15)
                            }
                            .frame(width: 330, height: 95)
                        }
                        .padding(.top, -18)
                    }
                }
            }
            .animation(.spring())
        }
    }
    
}



import SwiftUI

struct FotoElement: View {
    @State private var isShowingPhotoPicker = false
    @State private var selectedImages: [UIImage] = []
    let openGallery: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            Button(action: {
                openGallery()
                
                
            }, label: {
                HStack {
                    Image(systemName: "photo.badge.plus")
                        .foregroundColor(.black)
                    
                    
                    Text("Add photos & videos")
                        .foregroundColor(.black)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                }
            })
            .frame(width: 344, height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.red, lineWidth: 3)
            )
            .cornerRadius(12)
            .padding(.top, 5)

            
        }
        
    }
}

#Preview {
    FotoElement(openGallery: {})
}


#Preview {
    AddPhotos()
}
