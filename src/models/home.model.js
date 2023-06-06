const BaseModel = require('./base.model');


class HomeModel extends BaseModel {
    async getAllHomeStay() {
        const sql = 'SELECT * FROM HomeStay'
        return await this.querySql(sql)
    }

    async createHome(name, country, count_bedrooms, count_toilets, description, price) {
        const sql = `INSERT INTO HomeStay (name, country, count_bedrooms, count_toilets, description, price)
        VALUES ('${name}', '${country}', ${parseInt(count_bedrooms)}, ${parseInt(count_toilets)}, '${description}', ${parseInt(price)})`
        return await this.querySql(sql)
    }

    async deleteHome(id) {
        let sql = `DELETE FROM HOMESTAY WHERE ID = ${id}`;
        return await this.querySql(sql);
    }

    async findHomById(id) {
        let sql = `select * from HomeStay where id = ${parseInt(id)}`;
        return await this.querySql(sql);
    }
    async editlHome(id,
        homeName,
        homeCity,
        homeBed,
        homeRest,
        homePrice,
        homeDes
    ) {
        let sql = `UPDATE HOMESTAY
            SET NAME= '${homeName}', 
            CITY= '${homeCity}', 
            BEDROOM=${homeBed}, 
            RESTROOM=${homeRest}, 
            DES ='${homeDes}',
            PRICE=${homePrice} 
            WHERE ID = ${id}`;
        return await this.querySql(sql);
    }

}

module.exports = new HomeModel