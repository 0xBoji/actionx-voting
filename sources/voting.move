module voting::voting {
   use std::signer;
   use std::vector;
   use aptos_framework::account;
   use aptos_framework::event;


   // errors
   const E_NOT_INITIALIZED: u64 = 1;
   const E_ALREADY_VOTED: u64 = 2;
   const E_INVALID_VOTE: u64 = 3;


   // structs
   struct VotingState has key {
       yes_votes: u64,
       no_votes: u64,
       voters: vector<address>,
   }


   struct VoteEvent has drop, store {
       voter: address,
       vote: u64,
   }


   // events
   struct VotingEvents has key {
       vote_events: event::EventHandle<VoteEvent>,
   }


   // functions
   fun initialize(account: &signer) {
       let account_addr = signer::address_of(account);
      
       assert!(!exists<VotingState>(account_addr), E_NOT_INITIALIZED);
      
       move_to(account, VotingState {
           yes_votes: 0,
           no_votes: 0,
           voters: vector::empty<address>(),
       });


       move_to(account, VotingEvents {
           vote_events: account::new_event_handle<VoteEvent>(account),
       });
   }


   public entry fun vote(account: &signer, vote: u64) acquires VotingState, VotingEvents {
       let account_addr = signer::address_of(account);
       assert!(exists<VotingState>(@voting), E_NOT_INITIALIZED);
       assert!(vote == 0 || vote == 1, E_INVALID_VOTE);
      
       let state = borrow_global_mut<VotingState>(@voting);
      
       assert!(!vector::contains(&state.voters, &account_addr), E_ALREADY_VOTED);
      
       if (vote == 1) {
           state.yes_votes = state.yes_votes + 1;
       } else {
           state.no_votes = state.no_votes + 1;
       };
      
       vector::push_back(&mut state.voters, account_addr);


       // Emit vote event
       let events = borrow_global_mut<VotingEvents>(@voting);
       event::emit_event(&mut events.vote_events, VoteEvent {
           voter: account_addr,
           vote,
       });
   }


   #[view]
   public fun get_vote_counts(): (u64, u64) acquires VotingState {
       assert!(exists<VotingState>(@voting), E_NOT_INITIALIZED);
       let state = borrow_global<VotingState>(@voting);
       (state.yes_votes, state.no_votes)
   }
}