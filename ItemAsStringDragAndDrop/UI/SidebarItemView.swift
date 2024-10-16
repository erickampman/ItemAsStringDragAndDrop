//
//  SidebarItemView.swift
//  ItemAsStringDragAndDrop
//
//  Created by Eric Kampman on 10/7/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct SidebarItemView: View {
	let item: Item
	@Binding var itemManager: ItemManager
	@State var draggedItem: String?
	@State var highlight: Bool = false
//	@Binding var itemManager: ItemManager

	var body: some View {
		ZStack(alignment: .top) {
			Text("\(item.title) \(item.instance)")
				.font(.title3)
				.frame(width: 100, height: 40)
				.cornerRadius(10)
				.onDrop(of: [UTType.text],
						delegate: SidebarItemDropDelegate(itemID: item.id,
														  draggedID: $draggedItem,
														  highlight: $highlight,
														  itemManager: $itemManager))
			if highlight {
//				VStack {
					Image(systemName: "chevron.up")
						.resizable()
						.frame(width: 100, height: 14)
						.offset(x: 5, y: 5)
//					Spacer()
//						.frame(width: 90, height: 26)
//				}
			}
		}
	}
}

#Preview {
	@Previewable @State var itemManager = ItemManager()
	SidebarItemView(item: Item(title: "Foobar", instance: 1), itemManager: $itemManager)
}
