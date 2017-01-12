class StarredCompanies extends React.Component{
  constructor(){
    super();
    this.state = {
      companies: []
    };
  }

  componentDidMount(){
    const companies = this.props.companies

    this.setState ({ companies: companies || [] })
  }

  render() {
      return (
        <div className='card-holder col-xs-12 col-sm-6 col-md-4 col-lg-3 col-xl-2'>
          <CompanyList companies={ this.state.companies } remove={ this.removeStarredCompany.bind(this) } />
        </div>
      )
  }

  removeStarredCompany(id){
    var starredCompanies = this.state.companies.filter(company => company.id !== id);
    this.setState({companies: starredCompanies}, () => this.removeFromDatabase(id));
  }

  removeFromDatabase(id){
    $.ajax({
      url: '/starred_companies/' + id,
      type: 'DELETE'
    })
  }
};

const CompanyList = ({companies, remove}) => {
  return(
    <div>
      { companies.map( company => <Company {...company} remove={ remove } />) }
    </div>
    )
};

const Company = ({ name, website, products_services, headquarters, id, remove }) => {
  return(
    <div className='CompanyCard'>
      <h3> { name } </h3>
      <p> { website } </p>
      <p> { products_services } </p>
      <p> { headquarters } </p>
      <button onClick={()=> remove(id)}>Remove Starred Company</button>
    </div>
  )
}
