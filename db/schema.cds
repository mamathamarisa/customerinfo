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
 //orders: Composition of many Orders on orders.customer = $self;
}
entity Orders : cuid,managed {
   orderDate : Date;
   orderType: String(20);
   orderStatus: Association to status default '01';
   product: Association to Products;
   customer : Association to Customers;
}
entity Products : cuid,{
   productName: localized String(50);
   type: String(30);
   price: Decimal(10,2);
   category: String(30);
   
}
entity status{
   key code: String;
   name:String;
}
entity Employee :cuid,commonaspect.CommonFields {
   gender:String(10);
   email:String(20);
   phoneNumber:String(20);
   department:String(10);
    
}
 
 