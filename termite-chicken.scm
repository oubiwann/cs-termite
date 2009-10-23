;; File: "termite#.scm"
;; Copyright (C) 2005-2008 Guillaume Germain

;; This is the declaration file for the Termite system
(module termite
   (
      ;; Termite "primordials"
      self ! ? ?? !? on make-node spawn pid? 
      spawn-link remote-spawn remote-spawn-link
      ;; Useful
			  make-tag current-node
			  ;; Process linking for error propagation
			  inbound-link outbound-link full-link
			  ;; Wrap Gambit's I/O
			  spawn-output-port spawn-input-port
			  ;; Exceptions...
			  termite-exception? ;; actually that has to be exported for RECV ... 
			  ;; Migration
			  migrate-task migrate/proxy 
			  ;; Useful condition reporting/logging procedures
			  warning debug info
			  ;; Node stuff
			  node-init node? node-host node-port 
			  ;; Nameserver mechanism
			  ;;make-nameserver-node 
			  ;; OTP-style stuff (genserver)
			  make-server-plugin server:start server:start-link 
			  server:call server:cast server:stop 
			  ;; Distributed data structures
			  make-dict dict? dict->list dict-for-each dict-search 
			  dict-set! dict-ref dict-length
			  ;; Publishing and resolving names for services
			  publish-service unpublish-service resolve-service remote-service
			  ;; default init and node names for convenience
			  ;;init
                          node1 node2
			  ;;*termite-nameserver-port*
			  ;;*termite-cookie*
			  ;; Useful
			  ping
			  )
(import chicken scheme)
(use srfi-1 srfi-4 srfi-18 mailbox mailbox-threads tcp)
(use extras posix ports defstruct)
(require-library lookup-table s11n)
(import (prefix lookup-table chicken:))
(import (prefix s11n s11n:))

(define-syntax (compile-time-load form r c)
  (let ((filename (cadr form)))
  `(,(r 'load) ,filename)))

;implement or rename gambit functions to match their
;chicken equivalents
(include "gambit-glue.scm")

;; make it available at run-time
(import-for-syntax chicken scheme)
(begin-for-syntax 
(include "match-support.scm")
(include "match.scm"))

;; ----------------------------------------------------------------------------
;; Macros 

(include "match.scm")
(include "recv.scm")
(include "deftype.scm")
(include "uuid.scm")

(include "termite.scm")

)
