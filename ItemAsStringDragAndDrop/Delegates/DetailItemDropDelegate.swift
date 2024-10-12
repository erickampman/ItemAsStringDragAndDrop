//
//  DetailItemDropDelegate.swift
//  ItemAsStringDragAndDrop
//
//  Created by Eric Kampman on 10/8/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct DetailItemDropDelegate: DropDelegate {
	let itemID: String?
	@Binding var draggedID: String?
	@Binding var highlight: Bool
	@Binding var itemManager: ItemManager
	
	func performDrop(info: DropInfo) -> Bool {

		print("DetailItemDropDelegate \(String(describing: itemID)) performDrop")
		
		let myIndex = itemManager.trailingItemIndexForID(itemID!)
		if nil == myIndex {
			print("DetailItemDropDelegate \(String(describing: itemID)) performDrop: No index for itemID")
			return false
		}
		if let draggedID {
			switch itemManager.location(for: draggedID) {
			case .leading:
				// get the index in the leading items
				// insert in trailing items before this item
				// remove the item from leading items
				itemManager.insertForID(draggedID, at: myIndex!, location: .trailing)
				if let _ = itemManager.leadingItemIndexForID(draggedID) {
					itemManager.removeForID(draggedID, location: .leading)
				}
			case .trailing:
				// get the index in the trailing items
				if let trailingIndex = itemManager.trailingItemIndexForID(draggedID) {
					itemManager.removeForID(draggedID, location: .trailing)
					var updatedIndex = myIndex!
					if updatedIndex > trailingIndex {
						updatedIndex -= 1
					}
					itemManager.insertForID(draggedID, at: updatedIndex, location: .trailing)
				}
			default:
				break
			}
		} else {
			print("DetailItemDropDelegate performDrop -- draggedID is nil")
			return false
		}
		highlight = false
		return true
	}
	
	func dropExited(info: DropInfo) {
		highlight = false
	}
	
	func dropEntered(info: DropInfo) {
		print("DetailItemDropDelegate \(String(describing: itemID)) dropEntered")
		highlight = true

		let provider = info.itemProviders(for: [.text])
		guard let draggedItem = provider.first else {
			return
		}
		let _ = draggedItem.loadObject(ofClass: String.self) { str, err in
			guard let str else { return }
			
			self.draggedID = str
			print("DetailItemDropDelegate draggedItem: \(String(describing: self.draggedID))")
		}
	}
}
