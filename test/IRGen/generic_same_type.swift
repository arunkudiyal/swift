// RUN: %swift -target x86_64-apple-macosx10.9 %s -emit-ir -Onone | FileCheck %s

// FIXME: Should be a SIL test, but we can't parse same-type constraints
// <rdar://problem/16238241>

protocol Runcible {
  typealias Mince
  typealias Quince
}

struct Spoon<T: Runcible> {
  var t: T
}

// CHECK: define void @_T{{.*}}3foo{{.*}}(
func foo<T where T: Runcible, T == T.Mince> (t: T) -> Spoon<T> {
  return Spoon(t: t)
}

// <rdar://problem/16273572>
// Concrete-constrained associated types don't require IR parameters.
// CHECK-LABEL: define void @_TF17generic_same_type13intCollection{{.*}}(%swift.opaque* noalias, %swift.type* %C, i8** %C.CollectionType, %swift.type* %C.Generator, i8** %C.Generator.GeneratorType, %swift.type* %C.Generator.Element, %swift.type* %C._Element)
func intCollection<C: CollectionType where C.Index == Int>(x: C) {
}
