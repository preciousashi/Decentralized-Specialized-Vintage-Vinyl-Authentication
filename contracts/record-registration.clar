;; Record Registration Contract
;; Documents details of rare vinyl recordings

(define-data-var last-record-id uint u0)

(define-map records
  { record-id: uint }
  {
    title: (string-ascii 100),
    artist: (string-ascii 100),
    release-year: uint,
    label: (string-ascii 50),
    catalog-number: (string-ascii 30),
    format: (string-ascii 20),
    registered-by: principal,
    registered-at: uint
  }
)

(define-public (register-record
    (title (string-ascii 100))
    (artist (string-ascii 100))
    (release-year uint)
    (label (string-ascii 50))
    (catalog-number (string-ascii 30))
    (format (string-ascii 20)))
  (let
    ((new-id (+ (var-get last-record-id) u1)))

    (var-set last-record-id new-id)

    (map-set records
      { record-id: new-id }
      {
        title: title,
        artist: artist,
        release-year: release-year,
        label: label,
        catalog-number: catalog-number,
        format: format,
        registered-by: tx-sender,
        registered-at: block-height
      }
    )

    (ok new-id)
  )
)

(define-read-only (get-record (record-id uint))
  (map-get? records { record-id: record-id })
)

(define-read-only (get-last-record-id)
  (var-get last-record-id)
)

