;; Title: LiquidStack - Next-Generation Crypto Liquidity Protocol
;;
;; Summary:
;; LiquidStack transforms the DeFi landscape by enabling seamless conversion of 
;; dormant crypto assets into active capital through intelligent collateralization.
;; Unlock the full potential of your digital portfolio while preserving ownership.
;;
;; Description:
;; An innovative decentralized finance protocol that bridges the gap between 
;; asset ownership and capital accessibility. LiquidStack empowers users to 
;; leverage their cryptocurrency holdings as collateral for immediate liquidity 
;; without sacrificing long-term investment positions.
;;
;; Key Features:
;;   - Intelligent collateral management with real-time risk assessment
;;   - Multi-tier liquidation protection mechanisms
;;   - Adaptive interest rate optimization based on market conditions
;;   - Cross-protocol compatibility for maximum flexibility
;;   - Transparent governance with community-driven parameter adjustments
;;
;; Designed for the modern DeFi ecosystem, LiquidStack provides institutional-grade
;; security while maintaining the accessibility and innovation that defines 
;; decentralized finance. Experience the future of crypto liquidity today.
;;

;; CORE CONSTANTS & CONFIGURATION

(define-constant CONTRACT-OWNER tx-sender)

;; Error Code Registry
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INSUFFICIENT-COLLATERAL (err u101))
(define-constant ERR-BELOW-MINIMUM (err u102))
(define-constant ERR-INVALID-AMOUNT (err u103))
(define-constant ERR-ALREADY-INITIALIZED (err u104))
(define-constant ERR-NOT-INITIALIZED (err u105))
(define-constant ERR-INVALID-LIQUIDATION (err u106))
(define-constant ERR-LOAN-NOT-FOUND (err u107))
(define-constant ERR-LOAN-NOT-ACTIVE (err u108))
(define-constant ERR-INVALID-LOAN-ID (err u109))
(define-constant ERR-INVALID-PRICE (err u110))
(define-constant ERR-INVALID-ASSET (err u111))

;; Supported Asset Registry
(define-constant VALID-ASSETS (list "BTC" "STX"))

;; PROTOCOL STATE VARIABLES

(define-data-var platform-initialized bool false)
(define-data-var minimum-collateral-ratio uint u150) ;; 150% minimum collateral coverage
(define-data-var liquidation-threshold uint u120) ;; 120% liquidation trigger point
(define-data-var platform-fee-rate uint u1) ;; 1% protocol fee
(define-data-var total-btc-locked uint u0)
(define-data-var total-loans-issued uint u0)

;; DATA STRUCTURES & MAPPINGS

;; Loan Registry - Comprehensive loan tracking
(define-map loans
  { loan-id: uint }
  {
    borrower: principal,
    collateral-amount: uint,
    loan-amount: uint,
    interest-rate: uint,
    start-height: uint,
    last-interest-calc: uint,
    status: (string-ascii 20),
  }
)

;; User Portfolio Tracking
(define-map user-loans
  { user: principal }
  { active-loans: (list 10 uint) }
)