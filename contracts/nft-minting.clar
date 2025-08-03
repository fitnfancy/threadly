;; Threadly NFT Minting Contract
;; Clarity v2
;; Implements minting, transferring, burning, metadata updates, and royalty payouts

(define-constant ERR-NOT-AUTHORIZED u100)
(define-constant ERR-NOT-OWNER u101)
(define-constant ERR-TOKEN-EXISTS u102)
(define-constant ERR-TOKEN-NOT-FOUND u103)
(define-constant ERR-ZERO-ADDRESS u104)
(define-constant ERR-ROYALTY-PAYOUT u105)

(define-constant CONTRACT-NAME "Threadly NFT")
(define-constant CONTRACT-SYMBOL "TLNFT")

;; Admin
(define-data-var admin principal tx-sender)

;; NFT storage
(define-map token-owner uint principal)
(define-map token-uri uint (string-ascii 256))
(define-map token-royalty uint principal) ;; Creator to receive royalties

;; Token counter
(define-data-var total-supply uint u0)

;; Read-only: check admin
(define-private (is-admin)
  (is-eq tx-sender (var-get admin))
)

;; Public: transfer admin
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-admin) (err ERR-NOT-AUTHORIZED))
    (asserts! (not (is-eq new-admin 'SP000000000000000000002Q6VF78)) (err ERR-ZERO-ADDRESS))
    (var-set admin new-admin)
    (ok true)
  )
)

;; Public: mint NFT to recipient
(define-public (mint (recipient principal) (uri (string-ascii 256)) (creator principal))
  (begin
    (asserts! (is-admin) (err ERR-NOT-AUTHORIZED))
    (asserts! (not (is-eq recipient 'SP000000000000000000002Q6VF78)) (err ERR-ZERO-ADDRESS))
    (let ((token-id (+ (var-get total-supply) u1)))
      (map-set token-owner token-id recipient)
      (map-set token-uri token-id uri)
      (map-set token-royalty token-id creator)
      (var-set total-supply token-id)
      (ok token-id)
    )
  )
)

;; Public: transfer NFT
(define-public (transfer (token-id uint) (to principal))
  (let ((owner (default-to 'SP000000000000000000002Q6VF78 (map-get? token-owner token-id))))
    (begin
      (asserts! (not (is-eq owner 'SP000000000000000000002Q6VF78)) (err ERR-TOKEN-NOT-FOUND))
      (asserts! (is-eq tx-sender owner) (err ERR-NOT-OWNER))
      (asserts! (not (is-eq to 'SP000000000000000000002Q6VF78)) (err ERR-ZERO-ADDRESS))
      (map-set token-owner token-id to)
      (ok true)
    )
  )
)

;; Public: burn NFT
(define-public (burn (token-id uint))
  (let ((owner (default-to 'SP000000000000000000002Q6VF78 (map-get? token-owner token-id))))
    (begin
      (asserts! (not (is-eq owner 'SP000000000000000000002Q6VF78)) (err ERR-TOKEN-NOT-FOUND))
      (asserts! (is-eq tx-sender owner) (err ERR-NOT-OWNER))
      (map-delete token-owner token-id)
      (map-delete token-uri token-id)
      (map-delete token-royalty token-id)
      (ok true)
    )
  )
)

;; Public: update token URI (only admin)
(define-public (update-token-uri (token-id uint) (new-uri (string-ascii 256)))
  (begin
    (asserts! (is-admin) (err ERR-NOT-AUTHORIZED))
    (asserts! (is-some (map-get? token-owner token-id)) (err ERR-TOKEN-NOT-FOUND))
    (map-set token-uri token-id new-uri)
    (ok true)
  )
)

;; Public: simulate royalty payout (in real contract, would transfer STX)
(define-public (payout-royalty (token-id uint) (amount uint))
  (let ((creator (default-to 'SP000000000000000000002Q6VF78 (map-get? token-royalty token-id))))
    (begin
      (asserts! (not (is-eq creator 'SP000000000000000000002Q6VF78)) (err ERR-ROYALTY-PAYOUT))
      (ok {recipient: creator, amount: amount})
    )
  )
)

;; Read-only: get owner of token
(define-read-only (get-owner (token-id uint))
  (ok (default-to 'SP000000000000000000002Q6VF78 (map-get? token-owner token-id)))
)

;; Read-only: get token URI
(define-read-only (get-token-uri (token-id uint))
  (ok (default-to "" (map-get? token-uri token-id)))
)

;; Read-only: get total supply
(define-read-only (get-total-supply)
  (ok (var-get total-supply))
)

;; Read-only: get admin
(define-read-only (get-admin)
  (ok (var-get admin))
)
