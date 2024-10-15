
unit SDL_mutex;
interface

{
  Automatically converted by H2Pas 0.99.16 from SDL_mutex.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    SDL_mutex.h
}

Type
PSDL_Condition = ^TSDL_Condition;
PSDL_Mutex = ^TSDL_Mutex;
PSDL_RWLock = ^TSDL_RWLock;
PSDL_Semaphore = ^TSDL_Semaphore;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{
  Simple DirectMedia Layer
  Copyright (C) 1997-2024 Sam Lantinga <slouken@libsdl.org>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
 }
{$ifndef SDL_mutex_h_}
{$define SDL_mutex_h_}
{*
 * # CategoryMutex
 *
 * Functions to provide thread synchronization primitives.
  }
{$include <SDL3/SDL_stdinc.h>}
{$include <SDL3/SDL_atomic.h>}
{$include <SDL3/SDL_error.h>}
{$include <SDL3/SDL_thread.h>}
{**************************************************************************** }
{ Enable thread safety attributes only with clang.
 * The attributes can be safely erased when compiling with other compilers.
 *
 * To enable analysis, set these environment variables before running cmake:
 *      export CC=clang
 *      export CFLAGS="-DSDL_THREAD_SAFETY_ANALYSIS -Wthread-safety"
  }
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   

function SDL_CAPABILITY(x : longint) : longint;

const
  SDL_SCOPED_CAPABILITY = scoped_lockable;  
{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   

function SDL_GUARDED_BY(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_PT_GUARDED_BY(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ACQUIRED_BEFORE(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ACQUIRED_AFTER(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_REQUIRES(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_REQUIRES_SHARED(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ACQUIRE(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ACQUIRE_SHARED(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_RELEASE(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_RELEASE_SHARED(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_RELEASE_GENERIC(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_TRY_ACQUIRE(x,y : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_TRY_ACQUIRE_SHARED(x,y : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_EXCLUDES(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ASSERT_CAPABILITY(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ASSERT_SHARED_CAPABILITY(x : longint) : longint;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_RETURN_CAPABILITY(x : longint) : longint;

const
  SDL_NO_THREAD_SAFETY_ANALYSIS = no_thread_safety_analysis;  
{**************************************************************************** }
{$include <SDL3/SDL_begin_code.h>}
{ Set up for C function definitions, even when using C++  }
{ C++ extern C conditionnal removed }
{*
 *  \name Mutex functions
  }
{ @  }
{*
 * A means to serialize access to a resource between threads.
 *
 * Mutexes (short for "mutual exclusion") are a synchronization primitive that
 * allows exactly one thread to proceed at a time.
 *
 * Wikipedia has a thorough explanation of the concept:
 *
 * https://en.wikipedia.org/wiki/Mutex
 *
 * \since This struct is available since SDL 3.0.0.
  }
type
{*
 * Create a new mutex.
 *
 * All newly-created mutexes begin in the _unlocked_ state.
 *
 * Calls to SDL_LockMutex() will not return while the mutex is locked by
 * another thread. See SDL_TryLockMutex() to attempt to lock without blocking.
 *
 * SDL mutexes are reentrant.
 *
 * \returns the initialized and unlocked mutex or NULL on failure; call
 *          SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_DestroyMutex
 * \sa SDL_LockMutex
 * \sa SDL_TryLockMutex
 * \sa SDL_UnlockMutex
  }

function SDL_CreateMutex:PSDL_Mutex;cdecl;external;
{*
 * Lock the mutex.
 *
 * This will block until the mutex is available, which is to say it is in the
 * unlocked state and the OS has chosen the caller as the next thread to lock
 * it. Of all threads waiting to lock the mutex, only one may do so at a time.
 *
 * It is legal for the owning thread to lock an already-locked mutex. It must
 * unlock it the same number of times before it is actually made available for
 * other threads in the system (this is known as a "recursive mutex").
 *
 * This function does not fail; if mutex is NULL, it will return immediately
 * having locked nothing. If the mutex is valid, this function will always
 * block until it can lock the mutex, and return with it locked.
 *
 * \param mutex the mutex to lock.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_TryLockMutex
 * \sa SDL_UnlockMutex
  }
procedure SDL_LockMutex(mutex:PSDL_Mutex);cdecl;external;
{*
 * Try to lock a mutex without blocking.
 *
 * This works just like SDL_LockMutex(), but if the mutex is not available,
 * this function returns false immediately.
 *
 * This technique is useful if you need exclusive access to a resource but
 * don't want to wait for it, and will return to it to try again later.
 *
 * This function returns true if passed a NULL mutex.
 *
 * \param mutex the mutex to try to lock.
 * \returns true on success, false if the mutex would block.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_LockMutex
 * \sa SDL_UnlockMutex
  }
function SDL_TryLockMutex(mutex:PSDL_Mutex):Tbool;cdecl;external;
{*
 * Unlock the mutex.
 *
 * It is legal for the owning thread to lock an already-locked mutex. It must
 * unlock it the same number of times before it is actually made available for
 * other threads in the system (this is known as a "recursive mutex").
 *
 * It is illegal to unlock a mutex that has not been locked by the current
 * thread, and doing so results in undefined behavior.
 *
 * \param mutex the mutex to unlock.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_LockMutex
 * \sa SDL_TryLockMutex
  }
procedure SDL_UnlockMutex(mutex:PSDL_Mutex);cdecl;external;
{*
 * Destroy a mutex created with SDL_CreateMutex().
 *
 * This function must be called on any mutex that is no longer needed. Failure
 * to destroy a mutex will result in a system memory or resource leak. While
 * it is safe to destroy a mutex that is _unlocked_, it is not safe to attempt
 * to destroy a locked mutex, and may result in undefined behavior depending
 * on the platform.
 *
 * \param mutex the mutex to destroy.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_CreateMutex
  }
procedure SDL_DestroyMutex(mutex:PSDL_Mutex);cdecl;external;
{ @  }{ Mutex functions  }
{*
 *  \name Read/write lock functions
  }
{ @  }
{*
 * A mutex that allows read-only threads to run in parallel.
 *
 * A rwlock is roughly the same concept as SDL_Mutex, but allows threads that
 * request read-only access to all hold the lock at the same time. If a thread
 * requests write access, it will block until all read-only threads have
 * released the lock, and no one else can hold the thread (for reading or
 * writing) at the same time as the writing thread.
 *
 * This can be more efficient in cases where several threads need to access
 * data frequently, but changes to that data are rare.
 *
 * There are other rules that apply to rwlocks that don't apply to mutexes,
 * about how threads are scheduled and when they can be recursively locked.
 * These are documented in the other rwlock functions.
 *
 * \since This struct is available since SDL 3.0.0.
  }
type
{*
 * Create a new read/write lock.
 *
 * A read/write lock is useful for situations where you have multiple threads
 * trying to access a resource that is rarely updated. All threads requesting
 * a read-only lock will be allowed to run in parallel; if a thread requests a
 * write lock, it will be provided exclusive access. This makes it safe for
 * multiple threads to use a resource at the same time if they promise not to
 * change it, and when it has to be changed, the rwlock will serve as a
 * gateway to make sure those changes can be made safely.
 *
 * In the right situation, a rwlock can be more efficient than a mutex, which
 * only lets a single thread proceed at a time, even if it won't be modifying
 * the data.
 *
 * All newly-created read/write locks begin in the _unlocked_ state.
 *
 * Calls to SDL_LockRWLockForReading() and SDL_LockRWLockForWriting will not
 * return while the rwlock is locked _for writing_ by another thread. See
 * SDL_TryLockRWLockForReading() and SDL_TryLockRWLockForWriting() to attempt
 * to lock without blocking.
 *
 * SDL read/write locks are only recursive for read-only locks! They are not
 * guaranteed to be fair, or provide access in a FIFO manner! They are not
 * guaranteed to favor writers. You may not lock a rwlock for both read-only
 * and write access at the same time from the same thread (so you can't
 * promote your read-only lock to a write lock without unlocking first).
 *
 * \returns the initialized and unlocked read/write lock or NULL on failure;
 *          call SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_DestroyRWLock
 * \sa SDL_LockRWLockForReading
 * \sa SDL_LockRWLockForWriting
 * \sa SDL_TryLockRWLockForReading
 * \sa SDL_TryLockRWLockForWriting
 * \sa SDL_UnlockRWLock
  }

function SDL_CreateRWLock:PSDL_RWLock;cdecl;external;
{*
 * Lock the read/write lock for _read only_ operations.
 *
 * This will block until the rwlock is available, which is to say it is not
 * locked for writing by any other thread. Of all threads waiting to lock the
 * rwlock, all may do so at the same time as long as they are requesting
 * read-only access; if a thread wants to lock for writing, only one may do so
 * at a time, and no other threads, read-only or not, may hold the lock at the
 * same time.
 *
 * It is legal for the owning thread to lock an already-locked rwlock for
 * reading. It must unlock it the same number of times before it is actually
 * made available for other threads in the system (this is known as a
 * "recursive rwlock").
 *
 * Note that locking for writing is not recursive (this is only available to
 * read-only locks).
 *
 * It is illegal to request a read-only lock from a thread that already holds
 * the write lock. Doing so results in undefined behavior. Unlock the write
 * lock before requesting a read-only lock. (But, of course, if you have the
 * write lock, you don't need further locks to read in any case.)
 *
 * This function does not fail; if rwlock is NULL, it will return immediately
 * having locked nothing. If the rwlock is valid, this function will always
 * block until it can lock the mutex, and return with it locked.
 *
 * \param rwlock the read/write lock to lock.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_LockRWLockForWriting
 * \sa SDL_TryLockRWLockForReading
 * \sa SDL_UnlockRWLock
  }
procedure SDL_LockRWLockForReading(rwlock:PSDL_RWLock);cdecl;external;
{*
 * Lock the read/write lock for _write_ operations.
 *
 * This will block until the rwlock is available, which is to say it is not
 * locked for reading or writing by any other thread. Only one thread may hold
 * the lock when it requests write access; all other threads, whether they
 * also want to write or only want read-only access, must wait until the
 * writer thread has released the lock.
 *
 * It is illegal for the owning thread to lock an already-locked rwlock for
 * writing (read-only may be locked recursively, writing can not). Doing so
 * results in undefined behavior.
 *
 * It is illegal to request a write lock from a thread that already holds a
 * read-only lock. Doing so results in undefined behavior. Unlock the
 * read-only lock before requesting a write lock.
 *
 * This function does not fail; if rwlock is NULL, it will return immediately
 * having locked nothing. If the rwlock is valid, this function will always
 * block until it can lock the mutex, and return with it locked.
 *
 * \param rwlock the read/write lock to lock.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_LockRWLockForReading
 * \sa SDL_TryLockRWLockForWriting
 * \sa SDL_UnlockRWLock
  }
procedure SDL_LockRWLockForWriting(rwlock:PSDL_RWLock);cdecl;external;
{*
 * Try to lock a read/write lock _for reading_ without blocking.
 *
 * This works just like SDL_LockRWLockForReading(), but if the rwlock is not
 * available, then this function returns false immediately.
 *
 * This technique is useful if you need access to a resource but don't want to
 * wait for it, and will return to it to try again later.
 *
 * Trying to lock for read-only access can succeed if other threads are
 * holding read-only locks, as this won't prevent access.
 *
 * This function returns true if passed a NULL rwlock.
 *
 * \param rwlock the rwlock to try to lock.
 * \returns true on success, false if the lock would block.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_LockRWLockForReading
 * \sa SDL_TryLockRWLockForWriting
 * \sa SDL_UnlockRWLock
  }
function SDL_TryLockRWLockForReading(rwlock:PSDL_RWLock):Tbool;cdecl;external;
{*
 * Try to lock a read/write lock _for writing_ without blocking.
 *
 * This works just like SDL_LockRWLockForWriting(), but if the rwlock is not
 * available, then this function returns false immediately.
 *
 * This technique is useful if you need exclusive access to a resource but
 * don't want to wait for it, and will return to it to try again later.
 *
 * It is illegal for the owning thread to lock an already-locked rwlock for
 * writing (read-only may be locked recursively, writing can not). Doing so
 * results in undefined behavior.
 *
 * It is illegal to request a write lock from a thread that already holds a
 * read-only lock. Doing so results in undefined behavior. Unlock the
 * read-only lock before requesting a write lock.
 *
 * This function returns true if passed a NULL rwlock.
 *
 * \param rwlock the rwlock to try to lock.
 * \returns true on success, false if the lock would block.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_LockRWLockForWriting
 * \sa SDL_TryLockRWLockForReading
 * \sa SDL_UnlockRWLock
  }
function SDL_TryLockRWLockForWriting(rwlock:PSDL_RWLock):Tbool;cdecl;external;
{*
 * Unlock the read/write lock.
 *
 * Use this function to unlock the rwlock, whether it was locked for read-only
 * or write operations.
 *
 * It is legal for the owning thread to lock an already-locked read-only lock.
 * It must unlock it the same number of times before it is actually made
 * available for other threads in the system (this is known as a "recursive
 * rwlock").
 *
 * It is illegal to unlock a rwlock that has not been locked by the current
 * thread, and doing so results in undefined behavior.
 *
 * \param rwlock the rwlock to unlock.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_LockRWLockForReading
 * \sa SDL_LockRWLockForWriting
 * \sa SDL_TryLockRWLockForReading
 * \sa SDL_TryLockRWLockForWriting
  }
procedure SDL_UnlockRWLock(rwlock:PSDL_RWLock);cdecl;external;
{*
 * Destroy a read/write lock created with SDL_CreateRWLock().
 *
 * This function must be called on any read/write lock that is no longer
 * needed. Failure to destroy a rwlock will result in a system memory or
 * resource leak. While it is safe to destroy a rwlock that is _unlocked_, it
 * is not safe to attempt to destroy a locked rwlock, and may result in
 * undefined behavior depending on the platform.
 *
 * \param rwlock the rwlock to destroy.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_CreateRWLock
  }
procedure SDL_DestroyRWLock(rwlock:PSDL_RWLock);cdecl;external;
{ @  }{ Read/write lock functions  }
{*
 *  \name Semaphore functions
  }
{ @  }
{*
 * A means to manage access to a resource, by count, between threads.
 *
 * Semaphores (specifically, "counting semaphores"), let X number of threads
 * request access at the same time, each thread granted access decrementing a
 * counter. When the counter reaches zero, future requests block until a prior
 * thread releases their request, incrementing the counter again.
 *
 * Wikipedia has a thorough explanation of the concept:
 *
 * https://en.wikipedia.org/wiki/Semaphore_(programming)
 *
 * \since This struct is available since SDL 3.0.0.
  }
type
{*
 * Create a semaphore.
 *
 * This function creates a new semaphore and initializes it with the value
 * `initial_value`. Each wait operation on the semaphore will atomically
 * decrement the semaphore value and potentially block if the semaphore value
 * is 0. Each post operation will atomically increment the semaphore value and
 * wake waiting threads and allow them to retry the wait operation.
 *
 * \param initial_value the starting value of the semaphore.
 * \returns a new semaphore or NULL on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_DestroySemaphore
 * \sa SDL_SignalSemaphore
 * \sa SDL_TryWaitSemaphore
 * \sa SDL_GetSemaphoreValue
 * \sa SDL_WaitSemaphore
 * \sa SDL_WaitSemaphoreTimeout
  }

function SDL_CreateSemaphore(initial_value:TUint32):PSDL_Semaphore;cdecl;external;
{*
 * Destroy a semaphore.
 *
 * It is not safe to destroy a semaphore if there are threads currently
 * waiting on it.
 *
 * \param sem the semaphore to destroy.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_CreateSemaphore
  }
procedure SDL_DestroySemaphore(sem:PSDL_Semaphore);cdecl;external;
{*
 * Wait until a semaphore has a positive value and then decrements it.
 *
 * This function suspends the calling thread until the semaphore pointed to by
 * `sem` has a positive value, and then atomically decrement the semaphore
 * value.
 *
 * This function is the equivalent of calling SDL_WaitSemaphoreTimeout() with
 * a time length of -1.
 *
 * \param sem the semaphore wait on.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_SignalSemaphore
 * \sa SDL_TryWaitSemaphore
 * \sa SDL_WaitSemaphoreTimeout
  }
procedure SDL_WaitSemaphore(sem:PSDL_Semaphore);cdecl;external;
{*
 * See if a semaphore has a positive value and decrement it if it does.
 *
 * This function checks to see if the semaphore pointed to by `sem` has a
 * positive value and atomically decrements the semaphore value if it does. If
 * the semaphore doesn't have a positive value, the function immediately
 * returns false.
 *
 * \param sem the semaphore to wait on.
 * \returns true if the wait succeeds, false if the wait would block.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_SignalSemaphore
 * \sa SDL_WaitSemaphore
 * \sa SDL_WaitSemaphoreTimeout
  }
function SDL_TryWaitSemaphore(sem:PSDL_Semaphore):Tbool;cdecl;external;
{*
 * Wait until a semaphore has a positive value and then decrements it.
 *
 * This function suspends the calling thread until either the semaphore
 * pointed to by `sem` has a positive value or the specified time has elapsed.
 * If the call is successful it will atomically decrement the semaphore value.
 *
 * \param sem the semaphore to wait on.
 * \param timeoutMS the length of the timeout, in milliseconds, or -1 to wait
 *                  indefinitely.
 * \returns true if the wait succeeds or false if the wait times out.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_SignalSemaphore
 * \sa SDL_TryWaitSemaphore
 * \sa SDL_WaitSemaphore
  }
function SDL_WaitSemaphoreTimeout(sem:PSDL_Semaphore; timeoutMS:TSint32):Tbool;cdecl;external;
{*
 * Atomically increment a semaphore's value and wake waiting threads.
 *
 * \param sem the semaphore to increment.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_TryWaitSemaphore
 * \sa SDL_WaitSemaphore
 * \sa SDL_WaitSemaphoreTimeout
  }
procedure SDL_SignalSemaphore(sem:PSDL_Semaphore);cdecl;external;
{*
 * Get the current value of a semaphore.
 *
 * \param sem the semaphore to query.
 * \returns the current value of the semaphore.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_GetSemaphoreValue(sem:PSDL_Semaphore):TUint32;cdecl;external;
{ @  }{ Semaphore functions  }
{*
 *  \name Condition variable functions
  }
{ @  }
{*
 * A means to block multiple threads until a condition is satisfied.
 *
 * Condition variables, paired with an SDL_Mutex, let an app halt multiple
 * threads until a condition has occurred, at which time the app can release
 * one or all waiting threads.
 *
 * Wikipedia has a thorough explanation of the concept:
 *
 * https://en.wikipedia.org/wiki/Condition_variable
 *
 * \since This struct is available since SDL 3.0.0.
  }
type
{*
 * Create a condition variable.
 *
 * \returns a new condition variable or NULL on failure; call SDL_GetError()
 *          for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_BroadcastCondition
 * \sa SDL_SignalCondition
 * \sa SDL_WaitCondition
 * \sa SDL_WaitConditionTimeout
 * \sa SDL_DestroyCondition
  }

function SDL_CreateCondition:PSDL_Condition;cdecl;external;
{*
 * Destroy a condition variable.
 *
 * \param cond the condition variable to destroy.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_CreateCondition
  }
procedure SDL_DestroyCondition(cond:PSDL_Condition);cdecl;external;
{*
 * Restart one of the threads that are waiting on the condition variable.
 *
 * \param cond the condition variable to signal.
 *
 * \threadsafety It is safe to call this function from any thread.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_BroadcastCondition
 * \sa SDL_WaitCondition
 * \sa SDL_WaitConditionTimeout
  }
procedure SDL_SignalCondition(cond:PSDL_Condition);cdecl;external;
{*
 * Restart all threads that are waiting on the condition variable.
 *
 * \param cond the condition variable to signal.
 *
 * \threadsafety It is safe to call this function from any thread.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_SignalCondition
 * \sa SDL_WaitCondition
 * \sa SDL_WaitConditionTimeout
  }
procedure SDL_BroadcastCondition(cond:PSDL_Condition);cdecl;external;
{*
 * Wait until a condition variable is signaled.
 *
 * This function unlocks the specified `mutex` and waits for another thread to
 * call SDL_SignalCondition() or SDL_BroadcastCondition() on the condition
 * variable `cond`. Once the condition variable is signaled, the mutex is
 * re-locked and the function returns.
 *
 * The mutex must be locked before calling this function. Locking the mutex
 * recursively (more than once) is not supported and leads to undefined
 * behavior.
 *
 * This function is the equivalent of calling SDL_WaitConditionTimeout() with
 * a time length of -1.
 *
 * \param cond the condition variable to wait on.
 * \param mutex the mutex used to coordinate thread access.
 *
 * \threadsafety It is safe to call this function from any thread.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_BroadcastCondition
 * \sa SDL_SignalCondition
 * \sa SDL_WaitConditionTimeout
  }
procedure SDL_WaitCondition(cond:PSDL_Condition; mutex:PSDL_Mutex);cdecl;external;
{*
 * Wait until a condition variable is signaled or a certain time has passed.
 *
 * This function unlocks the specified `mutex` and waits for another thread to
 * call SDL_SignalCondition() or SDL_BroadcastCondition() on the condition
 * variable `cond`, or for the specified time to elapse. Once the condition
 * variable is signaled or the time elapsed, the mutex is re-locked and the
 * function returns.
 *
 * The mutex must be locked before calling this function. Locking the mutex
 * recursively (more than once) is not supported and leads to undefined
 * behavior.
 *
 * \param cond the condition variable to wait on.
 * \param mutex the mutex used to coordinate thread access.
 * \param timeoutMS the maximum time to wait, in milliseconds, or -1 to wait
 *                  indefinitely.
 * \returns true if the condition variable is signaled, false if the condition
 *          is not signaled in the allotted time.
 *
 * \threadsafety It is safe to call this function from any thread.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_BroadcastCondition
 * \sa SDL_SignalCondition
 * \sa SDL_WaitCondition
  }
function SDL_WaitConditionTimeout(cond:PSDL_Condition; mutex:PSDL_Mutex; timeoutMS:TSint32):Tbool;cdecl;external;
{ @  }{ Condition variable functions  }
{*
 *  \name Thread-safe initialization state functions
  }
{ @  }
{*
 * The current status of an SDL_InitState structure.
 *
 * \since This enum is available since SDL 3.0.0.
  }
type
  PSDL_InitStatus = ^TSDL_InitStatus;
  TSDL_InitStatus =  Longint;
  Const
    SDL_INIT_STATUS_UNINITIALIZED = 0;
    SDL_INIT_STATUS_INITIALIZING = 1;
    SDL_INIT_STATUS_INITIALIZED = 2;
    SDL_INIT_STATUS_UNINITIALIZING = 3;
;
{*
 * A structure used for thread-safe initialization and shutdown.
 *
 * Here is an example of using this:
 *
 * ```c
 *    static SDL_AtomicInitState init;
 *
 *    bool InitSystem(void)
 *    
 *        if (!SDL_ShouldInit(&init)) 
 *            // The system is initialized
 *            return true;
 *        
 *
 *        // At this point, you should not leave this function without calling SDL_SetInitialized()
 *
 *        bool initialized = DoInitTasks();
 *        SDL_SetInitialized(&init, initialized);
 *        return initialized;
 *    
 *
 *    bool UseSubsystem(void)
 *    
 *        if (SDL_ShouldInit(&init)) 
 *            // Error, the subsystem isn't initialized
 *            SDL_SetInitialized(&init, false);
 *            return false;
 *        
 *
 *        // Do work using the initialized subsystem
 *
 *        return true;
 *    
 *
 *    void QuitSystem(void)
 *    
 *        if (!SDL_ShouldQuit(&init)) 
 *            // The system is not initialized
 *            return true;
 *        
 *
 *        // At this point, you should not leave this function without calling SDL_SetInitialized()
 *
 *        DoQuitTasks();
 *        SDL_SetInitialized(&init, false);
 *    
 * ```
 *
 * Note that this doesn't protect any resources created during initialization,
 * or guarantee that nobody is using those resources during cleanup. You
 * should use other mechanisms to protect those, if that's a concern for your
 * code.
 *
 * \since This struct is available since SDL 3.0.0.
  }
type
  PSDL_InitState = ^TSDL_InitState;
  TSDL_InitState = record
      status : TSDL_AtomicInt;
      thread : TSDL_ThreadID;
      reserved : pointer;
    end;
{*
 * Return whether initialization should be done.
 *
 * This function checks the passed in state and if initialization should be
 * done, sets the status to `SDL_INIT_STATUS_INITIALIZING` and returns true.
 * If another thread is already modifying this state, it will wait until
 * that's done before returning.
 *
 * If this function returns true, the calling code must call
 * SDL_SetInitialized() to complete the initialization.
 *
 * \param state the initialization state to check.
 * \returns true if initialization needs to be done, false otherwise.
 *
 * \threadsafety It is safe to call this function from any thread.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_SetInitialized
 * \sa SDL_ShouldQuit
  }

function SDL_ShouldInit(state:PSDL_InitState):Tbool;cdecl;external;
{*
 * Return whether cleanup should be done.
 *
 * This function checks the passed in state and if cleanup should be done,
 * sets the status to `SDL_INIT_STATUS_UNINITIALIZING` and returns true.
 *
 * If this function returns true, the calling code must call
 * SDL_SetInitialized() to complete the cleanup.
 *
 * \param state the initialization state to check.
 * \returns true if cleanup needs to be done, false otherwise.
 *
 * \threadsafety It is safe to call this function from any thread.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_SetInitialized
 * \sa SDL_ShouldInit
  }
function SDL_ShouldQuit(state:PSDL_InitState):Tbool;cdecl;external;
{*
 * Finish an initialization state transition.
 *
 * This function sets the status of the passed in state to
 * `SDL_INIT_STATUS_INITIALIZED` or `SDL_INIT_STATUS_UNINITIALIZED` and allows
 * any threads waiting for the status to proceed.
 *
 * \param state the initialization state to check.
 * \param initialized the new initialization state.
 *
 * \threadsafety It is safe to call this function from any thread.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_ShouldInit
 * \sa SDL_ShouldQuit
  }
procedure SDL_SetInitialized(state:PSDL_InitState; initialized:Tbool);cdecl;external;
{ @  }{ Thread-safe initialization state functions  }
{ Ends C function definitions when using C++  }
{ C++ end of extern C conditionnal removed }
{$include <SDL3/SDL_close_code.h>}
{$endif}
{ SDL_mutex_h_  }

implementation

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_CAPABILITY(x : longint) : longint;
begin
  SDL_CAPABILITY:=capability(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_GUARDED_BY(x : longint) : longint;
begin
  SDL_GUARDED_BY:=guarded_by(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_PT_GUARDED_BY(x : longint) : longint;
begin
  SDL_PT_GUARDED_BY:=pt_guarded_by(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ACQUIRED_BEFORE(x : longint) : longint;
begin
  SDL_ACQUIRED_BEFORE:=acquired_before(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ACQUIRED_AFTER(x : longint) : longint;
begin
  SDL_ACQUIRED_AFTER:=acquired_after(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_REQUIRES(x : longint) : longint;
begin
  SDL_REQUIRES:=requires_capability(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_REQUIRES_SHARED(x : longint) : longint;
begin
  SDL_REQUIRES_SHARED:=requires_shared_capability(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ACQUIRE(x : longint) : longint;
begin
  SDL_ACQUIRE:=acquire_capability(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ACQUIRE_SHARED(x : longint) : longint;
begin
  SDL_ACQUIRE_SHARED:=acquire_shared_capability(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_RELEASE(x : longint) : longint;
begin
  SDL_RELEASE:=release_capability(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_RELEASE_SHARED(x : longint) : longint;
begin
  SDL_RELEASE_SHARED:=release_shared_capability(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_RELEASE_GENERIC(x : longint) : longint;
begin
  SDL_RELEASE_GENERIC:=release_generic_capability(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_TRY_ACQUIRE(x,y : longint) : longint;
begin
  SDL_TRY_ACQUIRE:=try_acquire_capability(x,y);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_TRY_ACQUIRE_SHARED(x,y : longint) : longint;
begin
  SDL_TRY_ACQUIRE_SHARED:=try_acquire_shared_capability(x,y);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_EXCLUDES(x : longint) : longint;
begin
  SDL_EXCLUDES:=locks_excluded(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ASSERT_CAPABILITY(x : longint) : longint;
begin
  SDL_ASSERT_CAPABILITY:=assert_capability(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_ASSERT_SHARED_CAPABILITY(x : longint) : longint;
begin
  SDL_ASSERT_SHARED_CAPABILITY:=assert_shared_capability(x);
end;

{ was #define dname(params) para_def_expr }
{ argument types are unknown }
{ return type might be wrong }   
function SDL_RETURN_CAPABILITY(x : longint) : longint;
begin
  SDL_RETURN_CAPABILITY:=lock_returned(x);
end;


end.
