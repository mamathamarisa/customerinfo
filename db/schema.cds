//namespace is used to refer the entity set in any other file and with this namespace data base table will be prefixed with deployment
namespace customer.data.model;
// Importing the cuid (Compact Unique Identifier) function from the SAP Common library.
// This function can be used to generate unique identifiers for entities.
 using { cuid,managed } from '@sap/cds/common';
 using{ custom.common.aspects as commonaspect } from './aspectsCommon';
 type commonType: String(15);
 entity Customers : cuid,managed,commonaspect.CommonFields{
  // key customerID : Integer;
  // key name: String(20);
  //address: String(50) @title : 'Address';
  address: String(50) @title : '{i18n>address}'; // address ress of i18file is binded here
  email: commonType default 'mamatha@sample.com';
  key phone: commonType;
  orders: Association to many Orders on orders.customer = $self;
 //orders: Composition to many Orders on orders.customer = $self;
}
entity Orders : cuid,managed {
   orderDate : Date;
   orderType: String(20);
   orderStatus: String(20);
   product: Association to Products;
   customer : Association to Customers;
}
entity Products : cuid,{
   productName: localized String(50);
   type: String(30);
   price: Decimal(10,2);
   category: String(30);
   
}
entity Employees {
    address: Association to Address on address.ID = address_ID;
    address_ID : Integer;
}
entity Address{
   key ID :Integer;// FK
}
 //type enum

//  type Gender: String enum {
//    male;
//    female;
//    nonbinary = "nonbinary";
//  }
