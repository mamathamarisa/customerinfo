using {customer.data.model as cust} from '../db/schema';

service CustomerService{
    @restrict:[
        {
              grant:'*',
              to:'adminrole'
        },
        {
            grant :'READ',
            to:'displayRole'
        }
    ]
    entity Customers as projection on cust.Customers;
    entity Orders as projection on cust.Orders;
    @readonly
    entity Products as projection on cust.Products;
    @capabilities:{
    ReadRestrictions.Readable:false,
    UpdateRestrictions.Updatable:true,
    DeleteRestrictions.Deletable:false
    }
    entity Employeesrv as projection on cust.Employee;
    action OrderStatus(ID:UUID) returns String;
}
annotate CustomerService.Customers with @odata.draft.enabled 