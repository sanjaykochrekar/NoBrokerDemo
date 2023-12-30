//
//  DetailVC.swift
//  NoBroker
//
//  Created by Sanju on 30/12/23.
//

import UIKit



class DetailVC: UIViewController {
    var collectionView: UICollectionView!
    var vm: DetailVM!
    
    override func loadView() {
        super.loadView()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createBasicListLayout())
        view.addSubview(collectionView)
        view.backgroundColor = .appBg
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.register(DetailImageCVCell.self, forCellWithReuseIdentifier: "DetailImageCVCell")
        collectionView.register(DetailProductTitleCVCell.self, forCellWithReuseIdentifier: "DetailProductTitleCVCell")
        collectionView.register(DetailProductDescriptionCVCell.self, forCellWithReuseIdentifier: "DetailProductDescriptionCVCell")
    }
    
    
    func createBasicListLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] (section, _) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.imageSection()
            default:
                return self?.textSection()
            }
        }
    }
    
    
    private func imageSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
    
    private func textSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)        
        return section
    }

}



// MARK: - UICollectionViewDataSource Methods
extension DetailVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        vm.getSectionCount()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.getRowCount(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = vm.getItemAtIndex(indexPath: indexPath) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.identifier, for: indexPath) as! ListCell
        cell.populate(data: item)
        return cell as! UICollectionViewCell
    }
}
