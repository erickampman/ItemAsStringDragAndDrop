//
//  ItemManager.swift
//  ItemAsStringDragAndDrop
//
//  Created by Eric Kampman on 10/8/24.
//

import SwiftUI

@Observable
class ItemManager {
	var leadingItems = [Item]()
	var trailingItems = [Item]()
	
	enum Location: String {
		case leading
		case trailing
		case missing
	}
	
	init() {
		leadingItems = Item.sidebarItems
		trailingItems = Item.detailItems
	}

	func leadingItemIndexForID(_ id: String) -> Int? {
		leadingItems.firstIndex { $0.id == id }
	}
	
	func trailingItemIndexForID(_ id: String) -> Int? {
		trailingItems.firstIndex { $0.id == id }
	}
	
	func location(for id: String) -> Location {
		if let _ = leadingItemIndexForID(id) {
			return .leading
		} else if let _ = trailingItemIndexForID(id) {
			return .trailing
		} else {
			return .missing
		}
	}
	
	func itemFromID(_ id: String) -> Item? {
		if let index = leadingItemIndexForID(id) {
			return leadingItems[index]
		} else if let index = trailingItemIndexForID(id) {
			return trailingItems[index]
		} else {
			return nil
		}
	}
	
	func appendForID(_ id: String, to location: Location) {
		switch location {
		case .leading:
			leadingItems.append(Item(id: id))
		case .trailing:
			trailingItems.append(Item(id: id))
		default:
			print("appendForID -- Unknown location")
//			fatalError("Unknown location: \(location)")
		}
	}
	
	func removeForID(_ id: String) {
		if let index = leadingItemIndexForID(id) {
			leadingItems.remove(at: index)
		} else if let index = trailingItemIndexForID(id) {
			trailingItems.remove(at: index)
		} else {
			print("removeForID -- Unknown location")
		}
	}
	
	func removeForID(_ id: String, location: Location) {
		switch location {
		case .leading:
			if let index = leadingItemIndexForID(id) {
				leadingItems.remove(at: index)
			} else {
				print("removeForID -- missing id in leadingItems")
			}
		case .trailing:
			if let index = trailingItemIndexForID(id) {
				trailingItems.remove(at: index)
			} else {
				print("removeForID -- missing id in trailing items")
			}
		default :
			print("removeForID -- Unknown location")
		}
	}
	
	func removeAtIndex(_ index: Int, location: Location) {
		switch location {
		case .leading:
			leadingItems.remove(at: index)
		case .trailing:
			trailingItems.remove(at: index)
		default:
			print("removeAtIndex -- Unknown location")
		}
	}
	
	func insertForID(_ id: String, at index: Int, location: Location) {
		switch location {
		case .leading:
			leadingItems.insert(Item(id: id), at: index)
		case .trailing:
			trailingItems.insert(Item(id: id), at: index)
		default:
			print("insertForID -- Unknown location")
		}
	}
	
}
