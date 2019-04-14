namespace CallsLocatorMap
{
    using System;
    using System.Data;
    using System.Data.SqlClient;

    public class GetCustomersFromDB
    {
        public void RunStoredProc()
        {
            SqlConnection conn = null;
            SqlDataReader rdr = null;
            var customers = new Customers();

            try
            {
                conn = new
                    SqlConnection("Server=(LocalDB/MSSQLLocalDb);DataBase=AdastraDB;Integrated Security=SSPI");
                conn.Open();

                SqlCommand cmd = new SqlCommand(
                    "Customers from filter", conn);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(
                new SqlParameter("@Age", customers.Age));
                new SqlParameter("@Gender", customers.Gender);

                rdr = cmd.ExecuteReader();
            }
            finally
            {
                if (conn != null)
                {
                    conn.Close();
                }
                if (rdr != null)
                {
                    rdr.Close();
                }
            }
        }
    }
}