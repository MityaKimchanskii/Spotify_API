//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    private let playlist: Playlist
    private var tracks: [AudioTrack] = []
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(RecomendedTrackCollectionViewCell.self,
                    forCellWithReuseIdentifier: RecomendedTrackCollectionViewCell.id)
        cv.register(PlaylistHeaderCollectionReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: PlaylistHeaderCollectionReusableView.id)
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    init(playlist: Playlist) {
        self.playlist = playlist
        
        super.init(nibName: nil, bundle: nil)
    }
    
    private var viewModels = [RecommendedTrackCellViewModel]()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItem()
        style()
        layout()
        fetchData()
    }
}

// MARK: - Methods
extension PlaylistViewController {
    
    private func setupNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    @objc private func didTapShare() {
        guard let url = URL(string: playlist.external_urls["spotify"] ?? "") else { return }
        
        let vc = UIActivityViewController(
            activityItems: [url],
            applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func fetchData() {
        APICaller.shared.getPlaylistDetails(for: playlist) { [weak self] result in
            switch result {
            case .success(let model):
                self?.tracks = model.tracks.items.compactMap({ $0.track })
                self?.viewModels = model.tracks.items.compactMap({
                    RecommendedTrackCellViewModel(
                        name: $0.track.name,
                        artistName: $0.track.artists.first?.name ?? "-",
                        artWorkURL: URL(string: $0.track.album?.images.first?.url ?? ""))
                })
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSourse
extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendedTrackCollectionViewCell.id, for: indexPath
        ) as? RecomendedTrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // Play song
        let index = indexPath.row
        let track = tracks[index]
        PlaybackPresenter.startPlayback(from: self, track: track)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }

        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: PlaylistHeaderCollectionReusableView.id,
            for: indexPath) as? PlaylistHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }

        let headerViewModel = PlaylistHeaderViewViewModel(
            name: playlist.name,
            ownerName: playlist.owner.display_name,
            description: playlist.description,
            artWork: URL(string: playlist.images.first?.url ?? ""))
        
        header.configure(with: headerViewModel)
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.width, height: view.height/2.5)
    }
}

extension PlaylistViewController: PlaylistHeaderCollectionReusableViewDelegate {
    func playButtonTapped(_ header: PlaylistHeaderCollectionReusableView) {
        PlaybackPresenter.startPlayback(from: self, tracks: tracks)
    }
}
