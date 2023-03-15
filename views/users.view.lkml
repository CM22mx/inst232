view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
# Repro
  dimension: state_enabled {
    label: "Accepted State"
    view_label: "Profile"
  #  description: "Whether the contact owner has completed registration by accepting Terms & Conditions"
    allow_fill: no
    sql: ${TABLE}.state is not null ;;

    case: {
      when: {
        sql: ${TABLE}.state = 'Texas' ;;
        label: "true"
      }

      when: {
        sql: ${TABLE}.state ='New York' ;;
        label: "false"
      }
}
}

      dimension: city_valid {
        label: "City Valid"
        view_label: "Profile"
        allow_fill: no
        sql: ${TABLE}.city is not null ;;

        case: {
          when: {
            sql: ${TABLE}.city = 'Houston' ;;
            label: "true"
          }

          when: {
            sql: ${TABLE}.city ='New York' ;;
            label: "false"
          }
}
}

          dimension: active_state_city_raw {
            label: "States-Cities true/false"
            view_label: "States-Cities"
            type: string
            sql: CASE WHEN ${TABLE}.state = 'Texas' and ${TABLE}.city= 'Houston' and ${TABLE}.country = 'USA' THEN "true"
              ELSE "false"
              END
              ;;
          }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      saralooker.count,
      sindhu.count,
      user_data.count
    ]
  }
}
