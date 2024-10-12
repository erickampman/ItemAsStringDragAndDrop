//
//  SidebarContainerDropDelegate.swift
//  ItemAsStringDragAndDrop
//
//  Created by Eric Kampman on 10/8/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct SidebarContainerDropDelegate: DropDelegate {
	@Binding var highlight: Bool
	@Binding var draggedID: String?
	@Binding var itemManager: ItemManager

	let id = UUID()
	
	func dropUpdated(info: DropInfo) {
		print("SidebarContainerDropDelegate \(id.description) dropUpdated")
	}
	
	func performDrop(info: DropInfo) -> Bool {
		print("SidebarContainerDropDelegate \(id.description) performDrop")
		
		if let draggedID {
			switch itemManager.location(for: draggedID) {
			case .leading:
				itemManager.appendForID(draggedID, to: .leading)
				itemManager.removeForID(draggedID)
			case .trailing:
				itemManager.removeForID(draggedID)
				itemManager.appendForID(draggedID, to: .leading)
			default:
				print("SidebarContainerDropDelegate \(id.description) performDrop: Could not find draggedID in leading or trailing items")

			}
		} else {
			print("SidebarContainerDropDelegate performDrop -- draggedID is nil")
			return false
		}
		highlight = false
		return true
	}
		
	/*
		So although we are "moving" Items from one place to another, the DropInfo
		data is just a string. I've fought with loadObject below, trying to use a
		Transferable object instead of a String, but I've given up.
	 
		The approach below should be ok as long as the items' ids are unique.
	 */
	func dropEntered(info: DropInfo) {
		print("SidebarContainerDropDelegate \(id.description) dropEntered")
		highlight = true

		let provider = info.itemProviders(for: [.text])
		guard let draggedItem = provider.first else {
			return
		}
		let _ = draggedItem.loadObject(ofClass: String.self) { str, err in
			guard let str else { return }
			
			self.draggedID = str
			print("SidebarContainerDropDelegate draggedItem: \(String(describing: self.draggedID))")
		}
	}

}
