package com.uritsolutions.libman.generator;

import java.io.Serializable;

import org.hibernate.HibernateException;
import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.id.IdentityGenerator;

import com.uritsolutions.libman.pojos.User;

public class ManualIdGenerator extends IdentityGenerator {

	@Override
	public Serializable generate(SharedSessionContractImplementor s, Object obj) throws HibernateException {
		if (obj == null)
			throw new HibernateException(new NullPointerException());
		System.out.println("GeneratorDebug: ID -> "+((User)obj).getId());

		if ((((User) obj).getId()) == 0) {
			Serializable id = super.generate(s, obj);
			return id;
		} else {
			return ((User) obj).getId();

		}

	}

}
