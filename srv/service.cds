using {customer.data.model as cust} from '../db/schema';

service CustomerService{
    entity Customers as projection on cust.Customers;
    entity Orders as projection on cust.Orders;
    entity Products as projection on cust.Products;
}

  