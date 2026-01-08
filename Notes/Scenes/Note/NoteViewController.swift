//
//  NoteViewController.swift
//  Notes
//
//  Created by elene malakmadze on 27.11.25.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: NotesViewModelProtocol = NotesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        setUpCollectionView()
        setUpNavigationBarItem()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadNotes()
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            NoteCollectionViewCell.self,
            forCellWithReuseIdentifier: "NoteCollectionViewCell"
        )
    }
    
    func setUpNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle"),
            style: .prominent,
            target: self,
            action: #selector(handlePlusButtonTapped)
        )
    }
    
    @objc func handlePlusButtonTapped() {
        let vc = UIStoryboard(name: "NoteDetails", bundle: nil).instantiateViewController(withIdentifier: "NoteDetailsViewController") as! NoteDetailsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func bindViewModel() {
            viewModel.refreshUI = {
                self.collectionView.reloadData()
            }
        }
}

extension NoteViewController {
    func setUpNavigation() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}

extension NoteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "NoteCollectionViewCell",
            for: indexPath
        ) as! NoteCollectionViewCell
        cell.configure(with: viewModel.notes[indexPath.row])
        return cell
    }
}

extension NoteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(
            name: "NoteDetails",
            bundle: nil
        ).instantiateViewController(withIdentifier: "NoteDetailsViewController") as! NoteDetailsViewController
        
        let selectedNote = viewModel.notes[indexPath.row]
               vc.indexOfNote = viewModel.getOriginalIndex(for: selectedNote)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NoteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let wh: CGFloat = collectionView.bounds.width / 4
        return CGSize(width: wh, height: wh)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        16
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension NoteViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterNotes(with: searchController.searchBar.text ?? "")
    }
}
