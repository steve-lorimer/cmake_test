// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: bar/message.proto

#ifndef PROTOBUF_bar_2fmessage_2eproto__INCLUDED
#define PROTOBUF_bar_2fmessage_2eproto__INCLUDED

#include <string>

#include <google/protobuf/stubs/common.h>

#if GOOGLE_PROTOBUF_VERSION < 2006000
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please update
#error your headers.
#endif
#if 2006001 < GOOGLE_PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>
#include <google/protobuf/extension_set.h>
#include <google/protobuf/unknown_field_set.h>
// @@protoc_insertion_point(includes)

// Internal implementation detail -- do not call these.
void  protobuf_AddDesc_bar_2fmessage_2eproto();
void protobuf_AssignDesc_bar_2fmessage_2eproto();
void protobuf_ShutdownFile_bar_2fmessage_2eproto();

class BarMsg;

// ===================================================================

class BarMsg : public ::google::protobuf::Message {
 public:
  BarMsg();
  virtual ~BarMsg();

  BarMsg(const BarMsg& from);

  inline BarMsg& operator=(const BarMsg& from) {
    CopyFrom(from);
    return *this;
  }

  inline const ::google::protobuf::UnknownFieldSet& unknown_fields() const {
    return _unknown_fields_;
  }

  inline ::google::protobuf::UnknownFieldSet* mutable_unknown_fields() {
    return &_unknown_fields_;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const BarMsg& default_instance();

  void Swap(BarMsg* other);

  // implements Message ----------------------------------------------

  BarMsg* New() const;
  void CopyFrom(const ::google::protobuf::Message& from);
  void MergeFrom(const ::google::protobuf::Message& from);
  void CopyFrom(const BarMsg& from);
  void MergeFrom(const BarMsg& from);
  void Clear();
  bool IsInitialized() const;

  int ByteSize() const;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input);
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const;
  ::google::protobuf::uint8* SerializeWithCachedSizesToArray(::google::protobuf::uint8* output) const;
  int GetCachedSize() const { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const;
  public:
  ::google::protobuf::Metadata GetMetadata() const;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // required string s = 1;
  inline bool has_s() const;
  inline void clear_s();
  static const int kSFieldNumber = 1;
  inline const ::std::string& s() const;
  inline void set_s(const ::std::string& value);
  inline void set_s(const char* value);
  inline void set_s(const char* value, size_t size);
  inline ::std::string* mutable_s();
  inline ::std::string* release_s();
  inline void set_allocated_s(::std::string* s);

  // @@protoc_insertion_point(class_scope:BarMsg)
 private:
  inline void set_has_s();
  inline void clear_has_s();

  ::google::protobuf::UnknownFieldSet _unknown_fields_;

  ::google::protobuf::uint32 _has_bits_[1];
  mutable int _cached_size_;
  ::std::string* s_;
  friend void  protobuf_AddDesc_bar_2fmessage_2eproto();
  friend void protobuf_AssignDesc_bar_2fmessage_2eproto();
  friend void protobuf_ShutdownFile_bar_2fmessage_2eproto();

  void InitAsDefaultInstance();
  static BarMsg* default_instance_;
};
// ===================================================================


// ===================================================================

// BarMsg

// required string s = 1;
inline bool BarMsg::has_s() const {
  return (_has_bits_[0] & 0x00000001u) != 0;
}
inline void BarMsg::set_has_s() {
  _has_bits_[0] |= 0x00000001u;
}
inline void BarMsg::clear_has_s() {
  _has_bits_[0] &= ~0x00000001u;
}
inline void BarMsg::clear_s() {
  if (s_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    s_->clear();
  }
  clear_has_s();
}
inline const ::std::string& BarMsg::s() const {
  // @@protoc_insertion_point(field_get:BarMsg.s)
  return *s_;
}
inline void BarMsg::set_s(const ::std::string& value) {
  set_has_s();
  if (s_ == &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    s_ = new ::std::string;
  }
  s_->assign(value);
  // @@protoc_insertion_point(field_set:BarMsg.s)
}
inline void BarMsg::set_s(const char* value) {
  set_has_s();
  if (s_ == &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    s_ = new ::std::string;
  }
  s_->assign(value);
  // @@protoc_insertion_point(field_set_char:BarMsg.s)
}
inline void BarMsg::set_s(const char* value, size_t size) {
  set_has_s();
  if (s_ == &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    s_ = new ::std::string;
  }
  s_->assign(reinterpret_cast<const char*>(value), size);
  // @@protoc_insertion_point(field_set_pointer:BarMsg.s)
}
inline ::std::string* BarMsg::mutable_s() {
  set_has_s();
  if (s_ == &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    s_ = new ::std::string;
  }
  // @@protoc_insertion_point(field_mutable:BarMsg.s)
  return s_;
}
inline ::std::string* BarMsg::release_s() {
  clear_has_s();
  if (s_ == &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    return NULL;
  } else {
    ::std::string* temp = s_;
    s_ = const_cast< ::std::string*>(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
    return temp;
  }
}
inline void BarMsg::set_allocated_s(::std::string* s) {
  if (s_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    delete s_;
  }
  if (s) {
    set_has_s();
    s_ = s;
  } else {
    clear_has_s();
    s_ = const_cast< ::std::string*>(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  }
  // @@protoc_insertion_point(field_set_allocated:BarMsg.s)
}


// @@protoc_insertion_point(namespace_scope)

#ifndef SWIG
namespace google {
namespace protobuf {


}  // namespace google
}  // namespace protobuf
#endif  // SWIG

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_bar_2fmessage_2eproto__INCLUDED
